// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:indrayani/module/exam_list_module/view_model/exam__list_view_model.dart';
// // import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
// // import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
// // import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// // import 'package:indrayani/utils/exam_card.dart';
// // import 'package:indrayani/utils/common_widgets/user_drawer.dart';
// // import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
// // import 'package:indrayani/utils/loader.dart';

// // class SubscriptionScreen extends StatefulWidget {
// //   const SubscriptionScreen({Key? key}) : super(key: key);

// //   @override
// //   _SubscriptionScreenState createState() => _SubscriptionScreenState();
// // }

// // class _SubscriptionScreenState extends State<SubscriptionScreen> {
// //   final ExamViewModel examViewModel = Get.put(ExamViewModel());

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
// //       showLoadingDialog();
// //       await examViewModel.getExamList();
// //       hideLoadingDialog();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return InternetAwareWidget(
// //       child: Scaffold(
// //           backgroundColor: bodyBGColor,
// //           appBar: const CustomAppBar(
// //             containerText: "SUBSCRIPTIONS",
// //             imagePath: "assets/images/Logo/logo100x100.png",
// //           ),
// //           drawer: const UserDrawer(),
// //           body: Stack(
// //             alignment: Alignment.center,
// //             children: [
// //               CustomPaint(
// //                 painter: HeaderCurvedContainer(),
// //                 child: SizedBox(
// //                   width: MediaQuery.of(context).size.width,
// //                   height: MediaQuery.of(context).size.height,
// //                 ),
// //               ),
// //               Obx(() {
// //                 return SingleChildScrollView(
// //                   child: Column(
// //                     children: [
// //                       ListView.builder(
// //                         // padding: const EdgeInsets.all(16.0),
// //                         itemCount: examViewModel.examListDataModel?.value
// //                                 ?.responseBody?.length ??
// //                             3,
// //                         itemBuilder: (context, index) {
// //                           return ExamCard(
// //                             title: examViewModel.examListDataModel?.value
// //                                     ?.responseBody?[index]?.examName ??
// //                                 'JEE',
// //                             difficulty: examViewModel.examListDataModel?.value
// //                                     ?.responseBody?[index]?.dificultyLevel ??
// //                                 'Difficult',
// //                             id: examViewModel.examListDataModel?.value
// //                                     ?.responseBody?[index]?.examId ??
// //                                 "JE001",
// //                             optedDate: examViewModel.examListDataModel?.value
// //                                     ?.responseBody?[index]?.optedOn ??
// //                                 "12-05-2023",
// //                             endDate: examViewModel.examListDataModel?.value
// //                                     ?.responseBody?[index]?.endDate ??
// //                                 "12-06-2024",
// //                             price: examViewModel.examListDataModel?.value
// //                                     ?.responseBody?[index]?.price ??
// //                                 0,
// //                             imageUrl: examViewModel.examListDataModel?.value
// //                                     ?.responseBody?[index]?.examImage ??
// //                                 '',
// //                             isSubscription:
// //                                 true, // Indicating subscription context
// //                           );
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               }),
// //             ],
// //           )),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/exam_list_module/view_model/exam__list_view_model.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/exam_card.dart';
// import 'package:indrayani/utils/loader.dart';
// import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';

// // class to draw the profile screen
// class SubscriptionScreen extends StatefulWidget {
//   @override
//   State<SubscriptionScreen> createState() => _SubscriptionScreenState();
// }

// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   final ExamViewModel examViewModel = Get.put(ExamViewModel());

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       showLoadingDialog();
//       await examViewModel.getExamList();
//       hideLoadingDialog();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: bodyBGColor,
//         appBar: const CustomAppBar(
//           containerText: "SUBSCRIPTIONS",
//           imagePath: "assets/images/Logo/logo100x100.png",
//         ),
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
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     Obx(() {
//                       return SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             ListView.builder(
//                               // padding: const EdgeInsets.all(16.0),
//                               itemCount: examViewModel.examListDataModel?.value
//                                       ?.responseBody?.length ??
//                                   3,
//                               itemBuilder: (context, index) {
//                                 return ExamCard(
//                                   title: examViewModel.examListDataModel?.value
//                                           ?.responseBody?[index]?.examName ??
//                                       'JEE',
//                                   difficulty: examViewModel
//                                           .examListDataModel
//                                           ?.value
//                                           ?.responseBody?[index]
//                                           ?.dificultyLevel ??
//                                       'Difficult',
//                                   id: examViewModel.examListDataModel?.value
//                                           ?.responseBody?[index]?.examId ??
//                                       "JE001",
//                                   optedDate: examViewModel
//                                           .examListDataModel
//                                           ?.value
//                                           ?.responseBody?[index]
//                                           ?.optedOn ??
//                                       "12-05-2023",
//                                   endDate: examViewModel
//                                           .examListDataModel
//                                           ?.value
//                                           ?.responseBody?[index]
//                                           ?.endDate ??
//                                       "12-06-2024",
//                                   price: examViewModel.examListDataModel?.value
//                                           ?.responseBody?[index]?.price ??
//                                       0,
//                                   imageUrl: examViewModel
//                                           .examListDataModel
//                                           ?.value
//                                           ?.responseBody?[index]
//                                           ?.examImage ??
//                                       '',
//                                   isSubscription: true,
//                                   color: Colors
//                                       .black, // Indicating subscription context
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
