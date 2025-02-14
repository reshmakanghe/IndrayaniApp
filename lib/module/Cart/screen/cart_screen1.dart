// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/Cart/model/cart_data_model.dart';
// import 'package:indrayani/module/Cart/view_model/exam_cart_view_model.dart';
// import 'package:indrayani/module/payment_module/screen/thank_you_page.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';

// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/common_widgets/user_drawer.dart';
// import 'package:indrayani/utils/exam_card.dart';
// // Import your ThankYouPage widget
// import 'package:intl/intl.dart';

// class CartScreen extends StatelessWidget {
//   final CartViewModel cartViewModel = Get.put(CartViewModel());

//   CartScreen({Key? key}) : super(key: key);

//   final List<Color> colorPattern = [
//     Color.fromARGB(225, 255, 248, 209),
//     Color.fromARGB(255, 177, 220, 226), // Peach color
//     Color.fromARGB(255, 255, 172, 106),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: bodyBGColor,
//         appBar: const CustomAppBar(
//           containerText: "MY CART",
//           imagePath: "assets/images/Logo/logo100x100.png",
//         ),
//         drawer: const UserDrawer(),
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             CustomPaint(
//               painter: HeaderCurvedContainer(),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//               ),
//             ),
//             Obx(() => Column(
//                   children: [
//                     if (cartViewModel.items.isEmpty)
//                       const Center(child: Text("No items in the cart")),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: cartViewModel.items.length,
//                         itemBuilder: (context, index) {
//                           final item = cartViewModel.items[index];
//                           final color =
//                               colorPattern[index % colorPattern.length];
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: ExamCard(
//                               title: item.title,
//                               difficulty: item.difficulty,
//                               id: item.id,
//                               price: item.price,
//                               imageUrl: item.imageUrl,
//                               optedDate: item.optedDate,
//                               endDate: item.endDate,
//                               isSubscription: item.isSubscription,
//                               color: color,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     if (cartViewModel.items.isNotEmpty)
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Text(
//                               "Total Quantity: ${cartViewModel.itemCount}",
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               "Total Amount: \$${cartViewModel.totalAmount.toStringAsFixed(2)}",
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             ElevatedButton(
//                               onPressed: () {
//                                 // Handle checkout process
//                                 // For demonstration, just navigate to ThankYouPage
//                                 Get.to(() => const ThankYouPage());
//                               },
//                               child: const Text("Checkout"),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
