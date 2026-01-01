import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  final VoidCallback? onCameraTap;
  final VoidCallback? onGalleryTap;
  const ImageSourceSheet({super.key, this.onCameraTap, this.onGalleryTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.brightBlue),
      child: Row(
        children: [
          IconButton(onPressed: onCameraTap, icon: Icon(Icons.camera)),
          IconButton(
            onPressed: onGalleryTap,
            icon: Icon(Icons.browse_gallery_rounded),
          ),
        ],
      ),
    );
  }
}
