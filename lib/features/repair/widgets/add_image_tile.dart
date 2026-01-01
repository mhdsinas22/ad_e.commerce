import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddImageTile extends StatelessWidget {
  final VoidCallback onTap;

  const AddImageTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),

      onTap: onTap,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: Icon(Icons.add, size: 28)),
      ),
    );
  }
}
