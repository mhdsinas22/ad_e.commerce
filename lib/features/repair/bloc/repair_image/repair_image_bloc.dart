import 'dart:io';

import 'package:ad_e_commerce/features/repair/data/datasources/cloudinary_remote_datasource.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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

class RemoveImage extends RepairImageEvent {
  final int index;
  const RemoveImage(this.index);
  @override
  List<Object> get props => [index];
}

class UploadImages extends RepairImageEvent {}

class ClearImages extends RepairImageEvent {}

// --- States ---
class RepairImageState extends Equatable {
  final List<File> images;
  final List<String> uploadedUrls;
  final bool isUploading;
  const RepairImageState({
    this.images = const [],
    this.uploadedUrls = const [],
    this.isUploading = false,
  });

  RepairImageState copyWith({
    List<File>? images,
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
  final CloudinaryRemoteDatasource cloudinaryRemoteDatasource;

  RepairImageBloc(this.cloudinaryRemoteDatasource) : super(RepairImageState()) {
    on<PickImage>(_onPickImage);
    on<RemoveImage>(_onRemoveImage);
    on<UploadImages>(_onUploadImages);
    on<ClearImages>(_onClearImages); // ✅ ADD
  }
  void _onClearImages(ClearImages event, Emitter<RepairImageState> emit) {
    emit(
      const RepairImageState(images: [], uploadedUrls: [], isUploading: false),
    );
  }

  Future<void> _onPickImage(
    PickImage event,
    Emitter<RepairImageState> emit,
  ) async {
    try {
      if (event.source == ImageSource.camera) {
        final XFile? pickedFile = await picker.pickImage(
          source: ImageSource.camera,
        );
        if (pickedFile == null) return;
        // List<File>.from(state.images)..add(File(pickedFile.path));
        emit(state.copyWith(images: [...state.images, File(pickedFile.path)]));
      } else {
        final List<XFile> pickedFiles = await picker.pickMultiImage();
        if (pickedFiles.isEmpty) return;
        emit(
          state.copyWith(
            images: [...state.images, ...pickedFiles.map((e) => File(e.path))],
          ),
        );
      }
    } catch (_) {
      // Handle permission errors or unexpected errors if needed
    }
  }

  void _onRemoveImage(RemoveImage event, Emitter<RepairImageState> emit) {
    final updatedImages = List<File>.from(state.images)..removeAt(event.index);

    emit(state.copyWith(images: updatedImages));
  }

  Future<void> _onUploadImages(
    UploadImages event,
    Emitter<RepairImageState> emit,
  ) async {
    emit(state.copyWith(isUploading: true));
    final urls = <String>[];
    try {
      for (final image in state.images) {
        final url = await cloudinaryRemoteDatasource.uploadImage(image);
        urls.add(url);
      }
      emit(state.copyWith(uploadedUrls: urls, isUploading: false));
    } catch (e) {
      emit(state.copyWith(isUploading: false));
    }
  }
}
