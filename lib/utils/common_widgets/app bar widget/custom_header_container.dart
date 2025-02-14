import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String imagePath;
  final String text;
  final double containerHeight;

  const CustomContainer({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.containerHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: containerHeight,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            color: Colors.black,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class CustomContainer extends StatelessWidget {
//   final String imagePath;
//   final String text;

//   const CustomContainer({
//     Key? key,
//     required this.imagePath,
//     required this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       height: MediaQuery.of(context).size.height * 0.064,
//       child: Row(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width * 0.2,
//             color: Colors.black,
//             child: Image.asset(
//               imagePath,
//               fit: BoxFit.contain,
//             ),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 text,
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
