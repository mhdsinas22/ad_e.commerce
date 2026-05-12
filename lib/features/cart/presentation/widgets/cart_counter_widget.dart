import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CartCounterWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartCounterWidget({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(icon: Icons.remove, onTap: onDecrement),
        const SizedBox(width: 12),
        AppTexts.semiBold("$quantity", fontSize: 16),
        const SizedBox(width: 12),
        _buildButton(icon: Icons.add, onTap: onIncrement),
      ],
    );
  }

  Widget _buildButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grayColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: Colors.black),
      ),
    );
  }
}
