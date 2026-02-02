import 'dart:io';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final VoidCallback onEditTap;

  const ProfileHeader({
    super.key,
    this.imageUrl,
    this.imageFile,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 150, // Visually estimated from image
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image:
                    imageFile != null
                        ? FileImage(imageFile!)
                        : (imageUrl != null && imageUrl!.isNotEmpty
                                ? NetworkImage(imageUrl!)
                                : const AssetImage(
                                  'assets/png/placeholder_avatar.png',
                                ))
                            as ImageProvider,
                fit: BoxFit.cover,
              ),
              color: Colors.grey.shade200,
            ),
            child:
                (imageFile == null && (imageUrl == null || imageUrl!.isEmpty))
                    ? const Icon(Icons.person, size: 80, color: Colors.grey)
                    : null,
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: GestureDetector(
              onTap: onEditTap,
              child: Container(
                width: 44, // Slightly larger for tap area
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF0055FF), // Bright blue from image
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
