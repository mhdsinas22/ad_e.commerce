abstract class ImageViewerEvent {}

class OpenViewer extends ImageViewerEvent {
  final int index;
  OpenViewer({required this.index});
}

class ChangeImage extends ImageViewerEvent {
  final int index;
  ChangeImage({required this.index});
}

class CloseViewer extends ImageViewerEvent {}
