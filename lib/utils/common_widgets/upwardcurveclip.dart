import 'package:flutter/material.dart';

// CustomPainter class for the header curved-container
class HeaderCurvedContainerPainter extends CustomPainter {
  final Color color;

  HeaderCurvedContainerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xffea5d49);

    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height - 150)
      ..quadraticBezierTo(
          size.width / 2, size.height - 250, size.width, size.height - 150)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }
  // @override
  // void paint(Canvas canvas, Size size) {
  //   Paint paint = Paint()..color = color;
  //   Path path = Path()
  //     ..relativeLineTo(0, 150)
  //     ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
  //     ..relativeLineTo(0, -150)
  //     ..close();

  //   canvas.drawPath(path, paint);
  // }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Reusable widget with an upward curve
class CurvedContainer extends StatelessWidget {
  final double height;
  final Color color;
  final Widget child;

  CurvedContainer({
    required this.height,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(
            MediaQuery.of(context).size.width,
            height,
          ),
          painter: HeaderCurvedContainerPainter(color: color),
        ),
        child,
      ],
    );
  }
}
