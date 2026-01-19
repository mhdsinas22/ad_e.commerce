enum Imageviewerstatus { initial, loading, success, failure }

class ImageViewerState {
  final Imageviewerstatus status;
  final int index;
  final bool isOpen;

  ImageViewerState({
    required this.status,
    required this.index,
    required this.isOpen,
  });
  factory ImageViewerState.initial() {
    return ImageViewerState(
      isOpen: false,
      index: 0,
      status: Imageviewerstatus.initial,
    );
  }

  ImageViewerState copyWith({
    Imageviewerstatus? status,
    int? index,
    bool? isOpen,
  }) {
    return ImageViewerState(
      status: status ?? this.status,
      index: index ?? this.index,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}
