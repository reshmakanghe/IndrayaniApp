import 'package:flutter/material.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_header_container.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final String imagePath;
  final String containerText;
  final double? height;

  const CustomAppBar(
      {Key? key,
      this.title,
      required this.imagePath,
      required this.containerText,
      this.height})
      : preferredSize =
            const Size.fromHeight(106.0), // Adjust total height as needed
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: Column(
        children: [
          AppBar(
            backgroundColor: primaryColor,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstantText(
                  text: title,
                ),
              ],
            ),
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  "assets/images/Logo/logo100x100.png",
                  height: 50.0, // Adjust the height to fit your AppBar
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomContainer(
                  imagePath: imagePath,
                  text: containerText,
                  containerHeight: 50.0, // Set a fixed height for the container
                ),
              ),
              Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width *
                    0.01, // Adjust width as needed
                height: 50.0, // Set a fixed height for the black container
              ),
            ],
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:indrayani/utils/common_widgets/custom_header_container.dart';
// import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   final Size preferredSize;
//   final String? title;

//   const CustomAppBar({Key? key, this.title})
//       : preferredSize = const Size.fromHeight(110.0),

//         // Total height including the white container
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: preferredSize.height,
//       child: Column(
//         children: [
//           AppBar(
//             backgroundColor: Colors.amber,
//             leading: Builder(
//               builder: (BuildContext context) {
//                 return IconButton(
//                   icon: Icon(Icons.menu),
//                   onPressed: () {
//                     Scaffold.of(context).openDrawer();
//                   },
//                 );
//               },
//             ),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ConstantText(text: title),
//               ],
//             ),
//             actions: [
//               Container(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: Image.asset(
//                   "assets/images/Logo/logo100x100.png",
//                   height: 50.0, // Adjust the height to fit your AppBar
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ],
//           ),
//           CustomContainer(
//             imagePath: '',
//             text: '',
//           ),
//           Container(
//             color: Colors.black,
//             width: MediaQuery.of(context).size.width *
//                 0.5, // Adjust width as needed
//             height: MediaQuery.of(context).size.height * 0.064,
//             // Additional widgets or empty container
//           ),
//         ],
//       ),
//     );
//   }
// }
