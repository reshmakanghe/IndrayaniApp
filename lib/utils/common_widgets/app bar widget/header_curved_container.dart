import 'package:flutter/material.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the white row
    Paint whitePaint = Paint()..color = Colors.white;
    Path whiteRowPath = Path()
      ..lineTo(0, 50) // Change this value to adjust the height of the row
      ..lineTo(
          size.width, 50) // Change this value to adjust the height of the row
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(whiteRowPath, whitePaint);

    // Draw the amber curved path
    Paint amberPaint = Paint()..color = primaryColor;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 280.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();

    canvas.drawPath(path, amberPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
