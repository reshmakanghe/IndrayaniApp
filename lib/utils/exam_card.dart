import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/Cart/model/cart_data_model.dart';
import 'package:indrayani/module/Cart/screen/cart_screen.dart';
import 'package:indrayani/module/Cart/view_model/exam_cart_view_model.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_screen/exam_questions_screen.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_view_model/exam_questions_view_model.dart';
import 'package:indrayani/module/home/screens/exam_details.dart'; // Import the ExamDetailsPage
import 'package:indrayani/module/home/view_model/home_view_model.dart';
import 'package:indrayani/module/home/view_model/home_view_model1.dart';
import 'package:indrayani/module/home/view_model/toggle_button_view_controller.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/constants/StringConstants/string_constants.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatefulWidget {
  final String? title;
  final String? difficulty;
  final String? id;
  final int? price;
  final String? imageUrl;
  final String? examType;
  final String? optedDate;
  final String? endDate;
  final String? startDate;
  final String? availableOn;
  final int? totalMarks;
  final int? duration;
  final int? totalQuestions;
  final bool isHomeScreen;
  final bool isTrending;
  final bool isCartScreen;
  final int? isPurchase;
  final Color color;

  ExamCard({
    Key? key,
    this.title,
    this.difficulty,
    this.id,
    this.price,
    this.imageUrl,
    this.optedDate,
    this.endDate,
    this.startDate,
    this.availableOn,
    this.examType,
    this.duration,
    this.totalQuestions,
    this.totalMarks,
    this.isPurchase,
    required this.isTrending,
    required this.color,
    required this.isHomeScreen,
    required this.isCartScreen,
  }) : super(key: key);

  @override
  State<ExamCard> createState() => _ExamCardState();
}

class _ExamCardState extends State<ExamCard> {
  final CartViewModel cartViewModel = Get.put(CartViewModel());
  final ToggleButtonsController toggleButtonsController =
      Get.put(ToggleButtonsController());
  ExamQuestionsViewModel examQuestionsViewModel =
      Get.put(ExamQuestionsViewModel());
  HomeDataViewModel homeDataViewModel = Get.put(HomeDataViewModel());

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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showLoadingDialog();
      await homeDataViewModel.getExamDetails(examCode: widget.id ?? "");
      hideLoadingDialog();
      // showLoadingDialog();
      // await homeDataViewModel.getUpcomingExamList();
      // hideLoadingDialog();
    });
    super.initState();
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    bool expired = isExpired(widget.endDate);

    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;

        return Card(
          color: widget.color,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 6,
          child: InkWell(
            onTap: () {
              if (widget.isTrending) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ExamDetailsPage(
                    examCode: widget.id ?? "",
                    isPurchase: widget.isPurchase ?? 0,
                    color: widget.color,
                  ),
                ));
              }
            },
            child: SizedBox(
              height: height > 800
                  ? 122
                  : height > 700
                      ? 120
                      : height > 650
                          ? 120
                          : height > 500
                              ? 118
                              : height > 400
                                  ? 118
                                  : 120,
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
                        height: (widget.isPurchase == 1)
                            ? height > 800
                                ? 175
                                : height > 700
                                    ? 150
                                    : height > 650
                                        ? 170
                                        : height > 500
                                            ? 165
                                            : height > 400
                                                ? 120
                                                : 135
                            : height > 800
                                ? 150
                                : height > 700
                                    ? 150
                                    : height > 650
                                        ? 170
                                        : height > 500
                                            ? 165
                                            : height > 400
                                                ? 120
                                                : 135,
                        color: Colors.white,
                        child: widget.imageUrl != null &&
                                widget.imageUrl!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Image.network(
                                  APIConfig.imagePath + (widget.imageUrl!),
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  'assets/Logo/logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                      ),
                    ),
                  ),
                  // Information section
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
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
                          ),
                          // SizedBox(
                          //     height: width > 600
                          //         ? 10
                          //         : width > 300
                          //             ? 2
                          //             : 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: AutoSizeText(
                              "${widget.title}",
                              style: TextStyle(
                                fontSize: height > 800
                                    ? 15
                                    : height > 700
                                        ? 14
                                        : height > 650
                                            ? 14
                                            : height > 500
                                                ? 13
                                                : height > 400
                                                    ? 11
                                                    : 12,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines:
                                  1, // You can set this to the maximum number of lines you want
                              minFontSize:
                                  10, // Minimum font size to use when adjusting
                              overflow: TextOverflow
                                  .ellipsis, // Optional: handles text overflow
                            ),
                          ),
                          if (!widget.isTrending)
                            SizedBox(
                              height: width > 600
                                  ? 40
                                  : width > 300
                                      ? 35
                                      : 38,
                            ),
                          if (!widget.isTrending)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Marks : ${widget.totalMarks ?? ""}",
                                  style: TextStyle(
                                    color:
                                        expired ? Colors.black : Colors.black,
                                    fontSize: height > 800
                                        ? 9
                                        : height > 700
                                            ? 11
                                            : height > 650
                                                ? 10
                                                : height > 500
                                                    ? 10
                                                    : height > 400
                                                        ? 10
                                                        : 10,
                                  ),
                                ),
                                SizedBox(
                                  height: width > 600
                                      ? 3
                                      : width > 300
                                          ? 0
                                          : 1,
                                ),
                                Text(
                                  "Available On :${formatDate(widget.availableOn) ?? ""}",
                                  style: TextStyle(
                                    color: expired ? Colors.black : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height > 800
                                        ? 9
                                        : height > 700
                                            ? 10
                                            : height > 650
                                                ? 10
                                                : height > 500
                                                    ? 8
                                                    : height > 400
                                                        ? 8
                                                        : 7,
                                  ),
                                ),
                              ],
                            )
                          else if (widget.isTrending && widget.isPurchase == 1)
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Text(
                                //   "Opted On:  ${formatDate(widget.startDate) ?? ""}",
                                //   style: TextStyle(
                                //     color:
                                //         expired ? Colors.black : Colors.black,
                                //     fontSize: height > 800
                                //         ? 10
                                //         : height > 700
                                //             ? 11
                                //             : height > 650
                                //                 ? 10
                                //                 : height > 500
                                //                     ? 8
                                //                     : height > 400
                                //                         ? 10
                                //                         : 14,
                                //   ),
                                // ),
                                // Text(
                                //   "End Date:  ${formatDate(widget.endDate) ?? ""}",
                                //   style: TextStyle(
                                //     color:
                                //         expired ? Colors.black : Colors.black,
                                //     fontSize: height > 800
                                //         ? 10
                                //         : height > 700
                                //             ? 12
                                //             : height > 650
                                //                 ? 10
                                //                 : height > 500
                                //                     ? 8
                                //                     : height > 400
                                //                         ? 10
                                //                         : 14,
                                //   ),
                                // ),
                              ],
                            ),
                          if (widget.isTrending) const Spacer(),
                          if (widget.isHomeScreen &&
                              widget.isPurchase == 0 &&
                              widget.isTrending)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₹ ${widget.price ?? 0}.00",
                                  style: TextStyle(
                                    fontSize: height > 800
                                        ? 10
                                        : height > 700
                                            ? 11
                                            : height > 650
                                                ? 10
                                                : height > 500
                                                    ? 10
                                                    : height > 400
                                                        ? 10
                                                        : 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    cartViewModel.addItem(CartItem(
                                      title: widget.title,
                                      difficulty: widget.difficulty,
                                      exam_code: widget.id,
                                      price: widget.price,
                                      imageUrl: widget.imageUrl,
                                    ));
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => CartScreen(),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    backgroundColor: Colors.black,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    minimumSize: const Size(10.0, 30.0),
                                  ),
                                  child: const Text(
                                    "Add to cart",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else if (widget.isHomeScreen &&
                              widget.isPurchase == 1 &&
                              widget.isTrending)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Marks:${widget.totalMarks ?? ""}",
                                  style: TextStyle(
                                    color:
                                        expired ? Colors.black : Colors.black,
                                    fontSize: height > 800
                                        ? 11
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
                                ElevatedButton(
                                  onPressed: () async {
                                    showLoadingDialog();
                                    homeDataViewModel.getExamDetails(
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
                                                          "${homeDataViewModel.examDetails.value?.responseBody?.first?.difficultyLevel ?? ""}",
                                                          // "${widget.difficulty ?? ""}",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${homeDataViewModel.examDetails.value?.responseBody?.first?.examCode}",
                                                          // "${widget.id}",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10.0,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                        "${homeDataViewModel.examDetails.value?.responseBody?.first?.examName ?? ""}")
                                                    // Text(widget.title ?? ""),
                                                  ],
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                    //         text: widget
                                                    //                 .examType ??
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
                                                            text:
                                                                ("${homeDataViewModel.examDetails.value?.responseBody?.first?.totalQuestions ?? ""}")),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const ConstantText(
                                                            text:
                                                                "Total Marks"),
                                                        ConstantText(
                                                            text:
                                                                "${homeDataViewModel.examDetails.value?.responseBody?.first?.totalMarks}"
                                                            // (widget
                                                            //     .totalMarks
                                                            //     .toString()
                                                            //     )
                                                            ),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const ConstantText(
                                                            text: "Duration"),
                                                        ConstantText(
                                                            text:
                                                                ("${homeDataViewModel.examDetails.value?.responseBody?.first?.examDuration}")),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const ConstantText(
                                                            text: "Exam Type"),
                                                        ConstantText(
                                                            text:
                                                                "${homeDataViewModel.examDetails.value?.responseBody?.first?.examType}")
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    ConstantText(
                                                        text: (homeDataViewModel
                                                            .examDetails
                                                            .value
                                                            ?.responseBody
                                                            ?.first
                                                            ?.examDesc)),
                                                    spaceWidget(height: 20.0),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Get.to(() => ExamScreen(
                                                              // isQuestionScreen: true,
                                                              examCode: homeDataViewModel
                                                                      .examDetails
                                                                      .value
                                                                      ?.responseBody
                                                                      ?.first
                                                                      ?.examCode ??
                                                                  "",
                                                            ));
                                                        // Navigator.of(context)
                                                        //     .push(
                                                        //         MaterialPageRoute(
                                                        //   builder: (context) =>
                                                        //       ExamScreen(
                                                        //     examCode: homeDataViewModel
                                                        //             .examDetails
                                                        //             .value
                                                        //             ?.responseBody
                                                        //             ?.first
                                                        //             ?.examCode ??
                                                        //         "",
                                                        //   ),
                                                        // ))
                                                        //     .then((_) {
                                                        //   // Reset state after navigation is complete
                                                        //   // examQuestionsViewModel
                                                        //   //     .isExamScreen.value = false;
                                                        // });
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    25.0),
                                                        backgroundColor:
                                                            Colors.black,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                        ),
                                                        minimumSize: const Size(
                                                            10.0, 30.0),
                                                      ),
                                                      child: Text(
                                                        "Start",
                                                        style: TextStyle(
                                                          fontSize: height > 800
                                                              ? 10
                                                              : height > 700
                                                                  ? 10
                                                                  : height > 650
                                                                      ? 5
                                                                      : height >
                                                                              500
                                                                          ? 8
                                                                          : height > 400
                                                                              ? 8
                                                                              : 7,
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
                                        horizontal: 23.0),
                                    backgroundColor: Colors.black,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    minimumSize: const Size(10.0, 30.0),
                                  ),
                                  child: Text(
                                    "Start",
                                    style: TextStyle(
                                      fontSize: height > 800
                                          ? 10
                                          : height > 700
                                              ? 10
                                              : height > 650
                                                  ? 10
                                                  : height > 500
                                                      ? 8
                                                      : height > 400
                                                          ? 8
                                                          : 7,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (widget.isCartScreen)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " ₹ ${widget.price ?? ""}.00",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    cartViewModel.removeItem(widget.id ?? "");
                                  },
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
