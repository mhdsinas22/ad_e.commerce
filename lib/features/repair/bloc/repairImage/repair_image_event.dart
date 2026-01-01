import 'dart:io';

abstract class RepairImageEvent {}

class PickImageFromCamera extends RepairImageEvent {}

class PickImageFromGallery extends RepairImageEvent {}

class AddRepairImage extends RepairImageEvent {
  final List<File>? image;
  AddRepairImage(this.image);
}

class RemoveRepairImage extends RepairImageEvent {
  final int index;
  RemoveRepairImage(this.index);
}
