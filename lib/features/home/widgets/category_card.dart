import 'package:flutter/material.dart';

enum CategoryCardLayout { horizontal, vertical }

enum CategoryCardSize { big, small }

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final CategoryCardLayout layout;
  final CategoryCardSize size;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
    required this.layout,
    this.size = CategoryCardSize.small,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isBig = size == CategoryCardSize.big;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(isBig ? 16 : 10),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF3FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child:
            layout == CategoryCardLayout.vertical
                ? _vertical(isBig)
                : _horizontal(isBig),
      ),
    );
  }

  Widget _vertical(bool isBig) {
    return Column(
      children: [
        Expanded(child: Image.asset(image, fit: BoxFit.contain)),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: isBig ? 15 : 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _horizontal(bool isBig) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isBig ? 15 : 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(child: Image.asset(image, fit: BoxFit.contain)),
      ],
    );
  }
}
