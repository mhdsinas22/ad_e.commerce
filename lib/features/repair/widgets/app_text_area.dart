import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final double borderraduis;
  final double width;
  final double height;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  const AppTextArea({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 4,
    this.borderraduis = 59,
    this.width = 365.21,
    this.height = 45,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.veryLightGrey,
                borderRadius: BorderRadius.circular(borderraduis),
              ),
              child: TextField(
                onChanged: (value) {
                  state.didChange(value);
                },
                keyboardType: keyboardType,
                controller: controller,
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 13.83,
                    color: Colors.grey.shade500,
                    fontFamily: "Manrope",
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (state.hasError) ...[
              const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontFamily: "Manrope",
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
