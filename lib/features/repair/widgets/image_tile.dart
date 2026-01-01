import 'dart:io';

import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final File image;
  final VoidCallback onRemove;

  const ImageTile({super.key, required this.image, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(image, width: 80, height: 80, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
