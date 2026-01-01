import 'dart:io';

import 'package:ad_e_commerce/features/repair/bloc/repairImage/repair_image_event.dart';
import 'package:ad_e_commerce/features/repair/bloc/repairImage/repair_image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RepairImageBloc extends Bloc<RepairImageEvent, RepairImageState> {
  final ImagePicker _picker = ImagePicker();
  RepairImageBloc() : super(const RepairImageState()) {
    on<PickImageFromCamera>(_onCameraPick);
    on<PickImageFromGallery>(_onGalleyPick);
    on<AddRepairImage>(_onImageSelected);
    on<RemoveRepairImage>(_onRemoveImage);
  }
  Future<void> _onCameraPick(
    PickImageFromCamera event,
    Emitter<RepairImageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    if (image != null) {
      add(AddRepairImage(File(image.path) as List<File>?));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onGalleyPick(
    PickImageFromGallery event,
    Emitter<RepairImageState> emit,
  ) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      add(AddRepairImage(File(image.path) as List<File>));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onImageSelected(AddRepairImage event, Emitter<RepairImageState> emit) {
    emit(state.copyWith(images: event.image, isLoading: false));
  }

  void _onRemoveImage(RemoveRepairImage event, Emitter<RepairImageState> emit) {
    emit(const RepairImageState());
  }
}
