import 'package:flutter/material.dart';

class AppTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  const AppTextArea({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
