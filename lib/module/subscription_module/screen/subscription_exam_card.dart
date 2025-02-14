import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_view_model/exam_questions_view_model.dart';
import 'package:indrayani/module/subscription_module/view_model/subscription_data_view_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
import 'package:intl/intl.dart';
import 'package:indrayani/module/Cart/view_model/exam_cart_view_model.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_screen/exam_questions_screen.dart';
import 'package:indrayani/module/subscription_module/screen/subscription_exam_details.dart';

class SubscriptionExamCard extends StatefulWidget {
  final String? title;
  final String? difficulty;
  final String? id;
  final int? price;
  final String? imageUrl;
  final String? optedDate;
  final String? endDate;
  final String? availableOn;
  final bool isSubscription;
  final Color color; // Color from parent

  SubscriptionExamCard({
    Key? key,
    this.title,
    this.difficulty,
    this.id,
    this.price,
    this.imageUrl,
    this.optedDate,
    this.endDate,
    this.availableOn,
    this.isSubscription = false,
    required this.color, // Required color parameter
  }) : super(key: key);

  @override
  State<SubscriptionExamCard> createState() => _SubscriptionExamCardState();
}

class _SubscriptionExamCardState extends State<SubscriptionExamCard> {
  final CartViewModel cartViewModel = Get.put(CartViewModel());
  ExamQuestionsViewModel examQuestionsViewModel =
      Get.put(ExamQuestionsViewModel());

  SubscriptionDataViewModel subscriptionDataViewModel =
      Get.put(SubscriptionDataViewModel());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showLoadingDialog();
      await subscriptionDataViewModel.getSubscribeExamDetails(
          examCode: widget.id ?? "");
      hideLoadingDialog();
      // showLoadingDialog();
      // await homeDataViewModel.getUpcomingExamList();
      // hideLoadingDialog();
    });
    super.initState();
    checkConnectivity();
  }

  bool isExpired(String? endDate) {
    if (endDate == null || endDate.isEmpty) return false;
    final endDateTime = DateFormat('dd-MM-yyyy').parse(endDate);
    return endDateTime.isBefore(DateTime.now());
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    bool expired = isExpired(widget.endDate);

    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;

        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SubscriptionExamDetails(
                color: widget.color,
                examCode: widget.id ?? "",
              ),
            ));
          },
          child: Card(
            color: widget.color,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            child: SizedBox(
              height: height > 800
                  ? 130
                  : height > 700
                      ? 130
                      : height > 650
                          ? 128
                          : height > 500
                              ? 128
                              : height > 400
                                  ? 126
                                  : 124, // Fixed height for the card
              child: Row(
                children: [
                  // Image section
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      child: Container(
                        color: Colors.white,
                        child: widget.imageUrl != null &&
                                widget.imageUrl!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.network(
                                  APIConfig.imagePath + (widget.imageUrl!),
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Image.asset(
                                  'assets/Logo/logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " ${widget.difficulty ?? ""}",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize: height > 800
                                      ? 10
                                      : height > 700
                                          ? 12
                                          : height > 650
                                              ? 8
                                              : height > 500
                                                  ? 8
                                                  : height > 400
                                                      ? 8
                                                      : 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                widget.id ?? "",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize: height > 800
                                      ? 10
                                      : height > 700
                                          ? 12
                                          : height > 650
                                              ? 8
                                              : height > 500
                                                  ? 8
                                                  : height > 400
                                                      ? 15
                                                      : 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: width > 600
                                  ? 5
                                  : width > 300
                                      ? 3
                                      : 0),
                          AutoSizeText(
                            "${widget.title}",
                            style: TextStyle(
                              fontSize: height > 800
                                  ? 15
                                  : height > 700
                                      ? 17
                                      : height > 650
                                          ? 14
                                          : height > 500
                                              ? 13
                                              : height > 400
                                                  ? 15
                                                  : 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines:
                                1, // You can set this to the maximum number of lines you want
                            minFontSize:
                                10, // Minimum font size to use when adjusting
                            overflow: TextOverflow
                                .ellipsis, // Optional: handles text overflow
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Opted On :  ${formatDate(widget.optedDate) ?? ""}",
                                style: TextStyle(
                                  color: expired ? Colors.black : Colors.black,
                                  fontSize: height > 800
                                      ? 10
                                      : height > 700
                                          ? 12
                                          : height > 650
                                              ? 10
                                              : height > 500
                                                  ? 10
                                                  : height > 400
                                                      ? 10
                                                      : 14,
                                ),
                              ),
                              Text(
                                "End Date :  ${formatDate(widget.endDate) ?? ""}",
                                style: TextStyle(
                                  color: expired ? Colors.black : Colors.black,
                                  fontSize: height > 800
                                      ? 10
                                      : height > 700
                                          ? 12
                                          : height > 650
                                              ? 10
                                              : height > 500
                                                  ? 10
                                                  : height > 400
                                                      ? 10
                                                      : 14,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showLoadingDialog();
                                  subscriptionDataViewModel
                                      .getSubscribeExamDetails(
                                          examCode: widget.id ?? "");
                                  hideLoadingDialog();
                                  examQuestionsViewModel.examCode.value =
                                      widget.id ?? "";
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Obx(() {
                                          return AlertDialog(
                                              title: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${widget.difficulty ?? ""}",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${subscriptionDataViewModel.subscribeExamDetailsDataModel.value?.responseBody?.first?.examCode ?? ""}",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.0,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Text(subscriptionDataViewModel
                                                          .subscribeExamDetailsDataModel
                                                          .value
                                                          ?.responseBody
                                                          ?.first
                                                          ?.examName ??
                                                      ""),
                                                ],
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .spaceBetween,
                                                  //   children: [
                                                  //     const ConstantText(
                                                  //         text: "Exam Type"),
                                                  //     ConstantText(
                                                  //         text: subscriptionDataViewModel
                                                  //                 .subscribeExamDetailsDataModel
                                                  //                 .value
                                                  //                 ?.responseBody
                                                  //                 ?.first
                                                  //                 ?.examType ??
                                                  //             "")
                                                  //   ],
                                                  // ),
                                                  // Divider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const ConstantText(
                                                          text:
                                                              "Total Question"),
                                                      ConstantText(
                                                          text: (subscriptionDataViewModel
                                                              .subscribeExamDetailsDataModel
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.totalQuestions
                                                              .toString())),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const ConstantText(
                                                          text: "Total Marks"),
                                                      ConstantText(
                                                          text: (subscriptionDataViewModel
                                                              .subscribeExamDetailsDataModel
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.totalMarks
                                                              .toString())),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const ConstantText(
                                                          text: "Duration"),
                                                      ConstantText(
                                                          text: (subscriptionDataViewModel
                                                              .subscribeExamDetailsDataModel
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.examDuration
                                                              .toString())),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const ConstantText(
                                                          text: "Exam Type"),
                                                      ConstantText(
                                                          text: subscriptionDataViewModel
                                                                  .subscribeExamDetailsDataModel
                                                                  .value
                                                                  ?.responseBody
                                                                  ?.first
                                                                  ?.examType ??
                                                              "")
                                                    ],
                                                  ),
                                                  Divider(),
                                                  ConstantText(
                                                      text: (subscriptionDataViewModel
                                                          .subscribeExamDetailsDataModel
                                                          .value
                                                          ?.responseBody
                                                          ?.first
                                                          ?.examDesc)),
                                                  spaceWidget(height: 20.0),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            ExamScreen(
                                                          examCode:
                                                              widget.id ?? "",
                                                        ),
                                                      ))
                                                          .then((_) {
                                                        // Reset state after navigation is complete
                                                        // examQuestionsViewModel
                                                        //     .isExamScreen.value = false;
                                                      });
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 25.0),
                                                      backgroundColor:
                                                          Colors.black,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                      ),
                                                      minimumSize: const Size(
                                                          10.0, 30.0),
                                                    ),
                                                    child: const Text(
                                                      "Start",
                                                      style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        });
                                      });

                                  // examQuestionsViewModel.isExamScreen.value =
                                  //     true; // Set state before navigation
                                  // Navigator.of(context)
                                  //     .push(MaterialPageRoute(
                                  //   builder: (context) => ExamScreen(
                                  //     examCode: widget.id ?? "",
                                  //   ),
                                  // ))
                                  //     .then((_) {
                                  //   // Reset state after navigation is complete
                                  //   // examQuestionsViewModel
                                  //   //     .isExamScreen.value = false;
                                  // });
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  backgroundColor: Colors.black,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  minimumSize: const Size(10.0, 30.0),
                                ),
                                child: const Text(
                                  "Start",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
