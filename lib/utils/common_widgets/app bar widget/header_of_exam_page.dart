import 'package:flutter/material.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';

class HeaderOfExamPage extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the white row
    Paint whitePaint = Paint()..color = Colors.white;
    double whiteRowHeight =
        10.0; // Decrease this value to adjust the height of the row
    Path whiteRowPath = Path()
      ..lineTo(0, whiteRowHeight)
      ..lineTo(size.width, whiteRowHeight)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(whiteRowPath, whitePaint);

    // Draw the amber curved path
    Paint amberPaint = Paint()..color = primaryColor;
    double amberCurveHeight =
        100.0; // Decrease this value to adjust the height of the curve
    Path path = Path()
      ..relativeLineTo(0, amberCurveHeight)
      ..quadraticBezierTo(
          size.width / 2, amberCurveHeight, size.width, amberCurveHeight)
      ..relativeLineTo(0, -amberCurveHeight)
      ..close();

    canvas.drawPath(path, amberPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
