// import 'dart:convert';
// import 'dart:math';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'dart:ui';
// import 'dart:ui';

// import 'package:flutter/material.dart';

// class PieChartPainter extends CustomPainter {
//   final Map<String, double> dataMap;
//   final List<Color> colorList;
//   final List<String> imagePaths;

//   PieChartPainter(this.dataMap, this.colorList, this.imagePaths);

//   @override
//   void paint(Canvas canvas, Size size) {
//     double total = dataMap.values.reduce((value, element) => value + element);

//     Rect rect = Rect.fromCircle(
//         center: Offset(size.width / 2, size.height / 2),
//         radius: size.width / 2);

//     double startAngle = -pi / 2;
//     double endAngle = 0.0;
//     int index = 0;

//     dataMap.forEach((key, value) {
//       Color color = colorList[index % colorList.length];
//       Paint sectionPaint = Paint()
//         ..color = color
//         ..style = PaintingStyle.fill;

//       double sweepAngle = (value / total) * 2 * pi;
//       canvas.drawArc(rect, startAngle, sweepAngle, true, sectionPaint);

//       // Place icon in the middle of the arc
//       double sectionMiddle = startAngle + sweepAngle / 2;
//       double iconX = size.width / 2 + size.width / 4 * cos(sectionMiddle);
//       double iconY = size.height / 2 + size.width / 4 * sin(sectionMiddle);

//       // Load and paint image
//       if (index < imagePaths.length) {
//         loadImage(imagePaths[index]).then((image) {
//           if (image != null) {
//             canvas.drawImageRect(
//               image,
//               Rect.fromPoints(Offset(0, 0),
//                   Offset(image.width.toDouble(), image.height.toDouble())),
//               Rect.fromCenter(
//                   center: Offset(iconX, iconY), width: 32, height: 32),
//               Paint(),
//             );
//           }
//         });
//       }

//       startAngle += sweepAngle;
//       index++;
//     });
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }

//   Future<ui.Image> loadImage(String path) async {
//     ByteData data = await rootBundle.load(path);
//     Uint8List bytes = data.buffer.asUint8List();
//     ui.Codec codec = await ui.instantiateImageCodec(bytes);
//     ui.FrameInfo frameInfo = await codec.getNextFrame();
//     return frameInfo.image;
//   }
// }
