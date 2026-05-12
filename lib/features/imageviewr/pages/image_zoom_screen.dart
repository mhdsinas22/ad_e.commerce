import 'package:aerstore/features/imageviewr/bloc/image_viewer_bloc.dart';
import 'package:aerstore/features/imageviewr/bloc/image_viewer_event.dart';
import 'package:aerstore/features/imageviewr/bloc/image_viewer_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageZoomScreen extends StatelessWidget {
  final List<String> images;
  const ImageZoomScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageViewerBloc(),
      child: _ImageZoomView(images: images),
    );
  }
}

class _ImageZoomView extends StatelessWidget {
  final List<String> images;

  const _ImageZoomView({required this.images});

  @override
  Widget build(BuildContext context) {
    final controller = PageController(
      initialPage: context.read<ImageViewerBloc>().state.index,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: controller,
            itemCount: images.length,
            onPageChanged: (index) {
              context.read<ImageViewerBloc>().add(ChangeImage(index: index));
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 3,
              );
            },
          ),

          // 🔙 Back
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
          ),

          // 🔢 Indicator
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: BlocBuilder<ImageViewerBloc, ImageViewerState>(
              builder: (context, state) {
                return Center(
                  child: Text(
                    '${state.index + 1} / ${images.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
