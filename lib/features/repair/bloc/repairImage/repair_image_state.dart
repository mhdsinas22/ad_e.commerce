import 'dart:io';

class RepairImageState {
  final List<File> images;
  final bool isLoading;
  const RepairImageState({this.images = const [], this.isLoading = false});
  RepairImageState copyWith({List<File>? images, bool? isLoading}) {
    return RepairImageState(
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
