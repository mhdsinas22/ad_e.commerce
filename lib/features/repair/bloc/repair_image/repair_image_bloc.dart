import 'package:ad_e_commerce/features/repair/data/datasources/repair_storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// --- Events ---
abstract class RepairImageEvent extends Equatable {
  const RepairImageEvent();
  @override
  List<Object> get props => [];
}

class PickImage extends RepairImageEvent {
  final ImageSource source;
  const PickImage(this.source);
  @override
  List<Object> get props => [source];
}

class PickSingleImage extends RepairImageEvent {
  final ImageSource source;
  const PickSingleImage(this.source);
  @override
  List<Object> get props => [source];
}

class RemoveImage extends RepairImageEvent {
  final int index;
  const RemoveImage(this.index);
  @override
  List<Object> get props => [index];
}

class UploadImages extends RepairImageEvent {}

class UploadSingleImage extends RepairImageEvent {}

class ClearImages extends RepairImageEvent {}

// --- States ---
class RepairImageState extends Equatable {
  final List<Uint8List> images;
  final List<String> uploadedUrls;
  final bool isUploading;

  const RepairImageState({
    this.images = const [],
    this.uploadedUrls = const [],
    this.isUploading = false,
  });

  RepairImageState copyWith({
    List<Uint8List>? images,
    List<String>? uploadedUrls,
    bool? isUploading,
  }) {
    return RepairImageState(
      images: images ?? this.images,
      uploadedUrls: uploadedUrls ?? this.uploadedUrls,
      isUploading: isUploading ?? this.isUploading,
    );
  }

  @override
  List<Object> get props => [images, uploadedUrls, isUploading];
}

// --- BLoC ---
class RepairImageBloc extends Bloc<RepairImageEvent, RepairImageState> {
  final ImagePicker picker = ImagePicker();
  final RepairStorageService repairStorageService;

  RepairImageBloc(this.repairStorageService) : super(const RepairImageState()) {
    on<PickImage>(_onPickImage);
    on<RemoveImage>(_onRemoveImage);
    on<UploadImages>(_onUploadImages);
    on<UploadSingleImage>((event, emit) async {
      if (state.images.isEmpty) return;

      emit(state.copyWith(isUploading: true));

      final image = state.images.last;

      final userId =
          Supabase.instance.client.auth.currentUser?.id ?? 'anonymous';

      try {
        final url = await repairStorageService.uploadRepairImageBytes(
          bytes: image,
          userId: userId,
        );

        emit(state.copyWith(uploadedUrls: [url], isUploading: false));
      } catch (e) {
        emit(state.copyWith(isUploading: false));
      }
    });

    on<ClearImages>(_onClearImages);
    on<PickSingleImage>(_onGalleryPick);
  }
  void _onClearImages(ClearImages event, Emitter<RepairImageState> emit) {
    emit(
      const RepairImageState(images: [], uploadedUrls: [], isUploading: false),
    );
  }

  Future<void> _onGalleryPick(
    PickSingleImage event,
    Emitter<RepairImageState> emit,
  ) async {
    final XFile? image = await picker.pickImage(
      source: event.source,
      imageQuality: 70,
    );
    if (image == null) return;

    final bytes = await image.readAsBytes();
    emit(state.copyWith(images: [bytes], uploadedUrls: [], isUploading: true));

    // Auto upload matches original behavior for single pick
    add(UploadSingleImage());
  }

  Future<void> _onPickImage(
    PickImage event,
    Emitter<RepairImageState> emit,
  ) async {
    try {
      if (kIsWeb) {
        // WEB
        final XFile? picked = await picker.pickImage(source: event.source);
        if (picked == null) return;
        final bytes = await picked.readAsBytes();
        emit(state.copyWith(images: [...state.images, bytes]));
      } else {
        //  ANDROID / IOS
        if (event.source == ImageSource.camera) {
          final XFile? pickedFile = await picker.pickImage(
            source: ImageSource.camera,
          );
          if (pickedFile == null) return;
          final bytes = await pickedFile.readAsBytes();
          emit(state.copyWith(images: [...state.images, bytes]));
        } else {
          if (event.source == ImageSource.gallery) {
            final files = await picker.pickMultiImage();
            if (files.isEmpty) return;
            final bytesList = await Future.wait(
              files.map((e) => e.readAsBytes()),
            );
            emit(state.copyWith(images: [...state.images, ...bytesList]));
          } else {
            final XFile? pickedFile = await picker.pickImage(
              source: event.source,
            );
            if (pickedFile == null) return;
            final bytes = await pickedFile.readAsBytes();
            emit(state.copyWith(images: [...state.images, bytes]));
          }
        }
      }
    } catch (_) {
      // Handle permission errors or unexpected errors if needed
    }
  }

  void _onRemoveImage(RemoveImage event, Emitter<RepairImageState> emit) {
    final updatedImages = List<Uint8List>.from(state.images)
      ..removeAt(event.index);

    emit(state.copyWith(images: updatedImages));
  }

  Future<void> _onUploadImages(
    UploadImages event,
    Emitter<RepairImageState> emit,
  ) async {
    emit(state.copyWith(isUploading: true));
    final urls = <String>[];
    try {
      final userId =
          Supabase.instance.client.auth.currentUser?.id ?? 'anonymous';
      for (final bytes in state.images) {
        final url = await repairStorageService.uploadRepairImageBytes(
          bytes: bytes,
          userId: userId,
        );
        urls.add(url);
      }
      emit(state.copyWith(uploadedUrls: urls, isUploading: false));
    } catch (e) {
      emit(state.copyWith(isUploading: false));
    }
  }
}
