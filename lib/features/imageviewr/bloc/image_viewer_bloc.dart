import 'package:aerstore/features/imageviewr/bloc/image_viewer_event.dart';
import 'package:aerstore/features/imageviewr/bloc/image_viewer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageViewerBloc extends Bloc<ImageViewerEvent, ImageViewerState> {
  ImageViewerBloc() : super(ImageViewerState.initial()) {
    on<OpenViewer>(_openViewer);
    on<ChangeImage>(_changeImage);
    on<CloseViewer>(_closeViewr);
  }
  void _openViewer(OpenViewer event, Emitter<ImageViewerState> emit) {
    emit(state.copyWith(isOpen: true, index: event.index));
  }

  void _changeImage(ChangeImage event, Emitter<ImageViewerState> emit) {
    emit(state.copyWith(index: event.index));
  }

  void _closeViewr(CloseViewer event, Emitter<ImageViewerState> emit) {
    emit(state.copyWith(isOpen: false));
  }
}
