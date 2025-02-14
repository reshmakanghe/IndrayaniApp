// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/exam_list_module/view_model/exam__list_view_model.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/exam_card.dart';
// import 'package:indrayani/utils/common_widgets/user_drawer.dart';
// import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
// import 'package:indrayani/utils/loader.dart';

// class SubscriptionScreen extends StatefulWidget {
//   const SubscriptionScreen({Key? key}) : super(key: key);

//   @override
//   _SubscriptionScreenState createState() => _SubscriptionScreenState();
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
//     return InternetAwareWidget(
//       child: Scaffold(
//           backgroundColor: bodyBGColor,
//           appBar: const CustomAppBar(
//             containerText: "SUBSCRIPTIONS",
//             imagePath: "assets/images/Logo/logo100x100.png",
//           ),
//           drawer: const UserDrawer(),
//           body: Stack(
//             alignment: Alignment.center,
//             children: [
//               CustomPaint(
//                 painter: HeaderCurvedContainer(),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                 ),
//               ),
//               Obx(() {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       ListView.builder(
//                         // padding: const EdgeInsets.all(16.0),
//                         itemCount: examViewModel.examListDataModel?.value
//                                 ?.responseBody?.length ??
//                             3,
//                         itemBuilder: (context, index) {
//                           return ExamCard(
//                             title: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.examName ??
//                                 'JEE',
//                             difficulty: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.dificultyLevel ??
//                                 'Difficult',
//                             id: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.examId ??
//                                 "JE001",
//                             optedDate: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.optedOn ??
//                                 "12-05-2023",
//                             endDate: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.endDate ??
//                                 "12-06-2024",
//                             price: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.price ??
//                                 0,
//                             imageUrl: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.examImage ??
//                                 '',
//                             isSubscription:
//                                 true, // Indicating subscription context
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ],
//           )),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/exam_list_module/view_model/exam__list_view_model.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/exam_card.dart';
// import 'package:indrayani/utils/common_widgets/user_drawer.dart';
// import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
// import 'package:indrayani/utils/loader.dart';

// class SubscriptionScreen extends StatefulWidget {
//   const SubscriptionScreen({Key? key}) : super(key: key);

//   @override
//   _SubscriptionScreenState createState() => _SubscriptionScreenState();
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
//     return InternetAwareWidget(
//       child: Scaffold(
//           backgroundColor: bodyBGColor,
//           appBar: const CustomAppBar(
//             containerText: "SUBSCRIPTIONS",
//             imagePath: "assets/images/Logo/logo100x100.png",
//           ),
//           drawer: const UserDrawer(),
//           body: Stack(
//             alignment: Alignment.center,
//             children: [
//               CustomPaint(
//                 painter: HeaderCurvedContainer(),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                 ),
//               ),
//               Obx(() {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       ListView.builder(
//                         // padding: const EdgeInsets.all(16.0),
//                         itemCount: examViewModel.examListDataModel?.value
//                                 ?.responseBody?.length ??
//                             3,
//                         itemBuilder: (context, index) {
//                           return ExamCard(
//                             title: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.examName ??
//                                 'JEE',
//                             difficulty: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.dificultyLevel ??
//                                 'Difficult',
//                             id: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.examId ??
//                                 "JE001",
//                             optedDate: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.optedOn ??
//                                 "12-05-2023",
//                             endDate: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.endDate ??
//                                 "12-06-2024",
//                             price: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.price ??
//                                 0,
//                             imageUrl: examViewModel.examListDataModel?.value
//                                     ?.responseBody?[index]?.examImage ??
//                                 '',
//                             isSubscription:
//                                 true, // Indicating subscription context
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ],
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/auth_module/signup/view_model/signup_view_model.dart';
import 'package:indrayani/module/subscription_module/model/subscription_data_model.dart';
import 'package:indrayani/module/subscription_module/screen/subscription_exam_card.dart';
import 'package:indrayani/module/subscription_module/view_model/subscription_data_view_model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/custom_bottom_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/home_custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final SubscriptionDataViewModel subscriptionDataViewModel =
      Get.put(SubscriptionDataViewModel());
  SignupViewModel signupViewModel = Get.put(SignupViewModel());

  final List<Map<String, dynamic>> subscriptionExams = [];
  final List<Color> colorPattern = [
    Color.fromARGB(225, 255, 248, 209),
    Color.fromARGB(255, 177, 220, 226), // Peach color
    Color.fromARGB(255, 255, 172, 106),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showLoadingDialog();
      await subscriptionDataViewModel.getSubscribedExam(
          userId:
              signupViewModel.signupDataModel?.value?.responseBody?.userId ??
                  IndrayaniAppGLobal.instance.loginViewModel.loginDataModel
                      ?.value?.responseBody?.userId ??
                  0);
      hideLoadingDialog();
      subscriptionDataViewModel.subscriptionExamsModels =
          subscriptionExams.map((exam) {
        return SubscriptionDataModel.fromJson(exam);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Load trending exams by default
    return Obx(
      () {
        final bottomBarVisibility =
            Get.find<NavigationController>().showBottomBar.value;
        return SafeArea(
          child: InternetAwareWidget(
            child: Scaffold(
              backgroundColor: bodyBGColor,
              appBar: const CustomAppBar(
                containerText: "SUBSCRIPTIONS",
                imagePath: "assets/Icon/subscription_icon.png",
              ),
              drawer: const UserDrawer(),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: HeaderCurvedContainer(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                  Obx(() {
                    var exams = subscriptionDataViewModel
                            .subscribeListExamDataModel.value?.responseBody ??
                        subscriptionDataViewModel.subscriptionExamsModels;

                    if (exams == null || exams.isEmpty) {
                      return const Center(
                        child: Text("No subscriptions available"),
                      );
                    } else {
                      return ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: exams.length + 1,
                        itemBuilder: (context, index) {
                          if (index == exams.length) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                            );
                          }
                          final exam = exams[index];
                          final color =
                              colorPattern[index % colorPattern.length];
                          return SubscriptionExamCard(
                            title: exam?.examName ?? "No Title",
                            difficulty: exam?.difficultyLevel ?? "Unknown",
                            id: exam?.examCode ?? "",
                            imageUrl: exam?.img ?? "",
                            optedDate: exam?.startDate ?? "",
                            endDate: exam?.endDate ?? "",
                            color: color,
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
              bottomNavigationBar:
                  bottomBarVisibility ? CustomBottomNavBar() : null,
            ),
          ),
        );
      },
    );
  }
}
