import 'dart:io';

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
  final File image;
  const RemoveImage(this.image);
  @override
  List<Object> get props => [image];
}

// --- States ---
class RepairImageState extends Equatable {
  final List<File> images;

  const RepairImageState({this.images = const []});

  RepairImageState copyWith({List<File>? images}) {
    return RepairImageState(images: images ?? this.images);
  }

  @override
  List<Object> get props => [images];
}

// --- BLoC ---
class RepairImageBloc extends Bloc<RepairImageEvent, RepairImageState> {
  final ImagePicker _picker;

  RepairImageBloc({ImagePicker? picker})
    : _picker = picker ?? ImagePicker(),
      super(const RepairImageState()) {
    on<PickImage>(_onPickImage);
    on<RemoveImage>(_onRemoveImage);
  }

  Future<void> _onPickImage(
    PickImage event,
    Emitter<RepairImageState> emit,
  ) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: event.source);
      if (pickedFile != null) {
        final newImages = List<File>.from(state.images)
          ..add(File(pickedFile.path));
        emit(state.copyWith(images: newImages));
      }
    } catch (_) {
      // Handle permission errors or unexpected errors if needed
    }
  }

  void _onRemoveImage(RemoveImage event, Emitter<RepairImageState> emit) {
    final newImages = List<File>.from(state.images)..remove(event.image);
    emit(state.copyWith(images: newImages));
  }
}
