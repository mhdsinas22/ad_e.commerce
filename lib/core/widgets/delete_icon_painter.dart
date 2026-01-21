import 'package:flutter/material.dart';

class DeleteIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;

    // bin body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(6, 10, size.width - 12, size.height - 16),
        const Radius.circular(6),
      ),
      paint,
    );

    // lid
    canvas.drawLine(Offset(4, 8), Offset(size.width - 4, 8), paint);

    // handle
    canvas.drawLine(
      Offset(size.width / 2 - 6, 4),
      Offset(size.width / 2 + 6, 4),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
