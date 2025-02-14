import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:indrayani/module/Cart/model/cart_data_model.dart';
import 'package:indrayani/module/Cart/screen/cart_screen.dart';
import 'package:indrayani/module/Cart/view_model/exam_cart_view_model.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_screen/exam_questions_screen.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_view_model/exam_questions_view_model.dart';
import 'package:indrayani/module/home/screens/home_screen.dart';
import 'package:indrayani/module/home/view_model/home_view_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/custom_bottom_bar.dart';

import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/bottom_bar_widget/screen/bottom_bar_widget.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/constants/StringConstants/string_constants.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
import 'package:intl/intl.dart';

class ExamDetailsPage extends StatefulWidget {
  late String examCode;
  int? isPurchase;
  late final Color color;
  ExamDetailsPage({
    super.key,
    required this.examCode,
    this.isPurchase,
    required this.color,
  });

  @override
  State<ExamDetailsPage> createState() => _ExamDetailsPageState();
}

class _ExamDetailsPageState extends State<ExamDetailsPage> {
  HomeDataViewModel homeDataViewModel = Get.put(HomeDataViewModel());
  // APIConfig imagePath = Get.put(APIConfig());
  CartViewModel cartViewModel = Get.put(CartViewModel());
  ExamQuestionsViewModel examQuestionsViewModel =
      Get.put(ExamQuestionsViewModel());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showLoadingDialog();
      await homeDataViewModel.getExamDetails(examCode: widget.examCode);
      hideLoadingDialog();
      // showLoadingDialog();
      // await homeDataViewModel.getUpcomingExamList();
      // hideLoadingDialog();
    });
    super.initState();
    checkConnectivity();
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    DateTime dateTime =
        DateTime.parse(dateStr); // Assuming the dateStr is in yyyy-MM-dd format
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(
      () {
        final bottomBarVisibility =
            Get.find<NavigationController>().showBottomBar.value;
        return SafeArea(
          child: InternetAwareWidget(
            child: Obx(() {
              return Scaffold(
                backgroundColor: bodyBGColor,
                appBar: const CustomAppBar(
                  containerText: "ABOUT EXAM",
                  imagePath: "assets/Abuout_EXAM/icon.png",
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Card(
                                          color: widget.color,
                                          margin:
                                              const EdgeInsets.only(top: 15.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          elevation: 6,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: screenHeight > 800
                                                      ? 150
                                                      : screenHeight > 700
                                                          ? 140
                                                          : screenHeight > 650
                                                              ? 130
                                                              : screenHeight >
                                                                      500
                                                                  ? 120
                                                                  : screenHeight >
                                                                          400
                                                                      ? 120
                                                                      : 125,
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(13),
                                                        topLeft:
                                                            Radius.circular(13),
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: homeDataViewModel
                                                                    .examDetails
                                                                    .value
                                                                    ?.responseBody
                                                                    ?.first
                                                                    ?.img !=
                                                                null
                                                            ? Image.network(
                                                                APIConfig
                                                                        .imagePath +
                                                                    (homeDataViewModel
                                                                            .examDetails
                                                                            .value
                                                                            ?.responseBody
                                                                            ?.first
                                                                            ?.img ??
                                                                        ""),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2,
                                                              )
                                                            : Image.asset(
                                                                'assets/Logo/logo.png',
                                                                fit: BoxFit
                                                                    .contain,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2,
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListTile(
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          homeDataViewModel
                                                                  .examDetails
                                                                  .value
                                                                  ?.responseBody
                                                                  ?.first
                                                                  ?.examName ??
                                                              "",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 17
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 16
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 14
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 13
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 10
                                                                                : 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              homeDataViewModel
                                                                          .examDetails
                                                                          .value
                                                                          ?.responseBody
                                                                          ?.first
                                                                          ?.examCode !=
                                                                      null
                                                                  ? "(${homeDataViewModel.examDetails.value?.responseBody?.first?.examCode})"
                                                                  : "",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.4),
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        800
                                                                    ? 12
                                                                    : MediaQuery.of(context).size.height >
                                                                            700
                                                                        ? 12
                                                                        : MediaQuery.of(context).size.height >
                                                                                650
                                                                            ? 10
                                                                            : MediaQuery.of(context).size.height > 500
                                                                                ? 8
                                                                                : MediaQuery.of(context).size.height > 400
                                                                                    ? 10
                                                                                    : 14,
                                                              ),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                            Text(
                                                              "Difficulty: ${homeDataViewModel.examDetails.value?.responseBody?.first?.difficultyLevel ?? ""}",
                                                              style: TextStyle(
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        800
                                                                    ? 12
                                                                    : MediaQuery.of(context).size.height >
                                                                            700
                                                                        ? 12
                                                                        : MediaQuery.of(context).size.height >
                                                                                650
                                                                            ? 10
                                                                            : MediaQuery.of(context).size.height > 500
                                                                                ? 8
                                                                                : MediaQuery.of(context).size.height > 400
                                                                                    ? 10
                                                                                    : 14,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Opted On: ${formatDate(homeDataViewModel.examDetails.value?.responseBody?.first?.availableOn) ?? ""}",
                                                              style: TextStyle(
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        800
                                                                    ? 12
                                                                    : MediaQuery.of(context).size.height >
                                                                            700
                                                                        ? 12
                                                                        : MediaQuery.of(context).size.height >
                                                                                650
                                                                            ? 10
                                                                            : MediaQuery.of(context).size.height > 500
                                                                                ? 8
                                                                                : MediaQuery.of(context).size.height > 400
                                                                                    ? 10
                                                                                    : 14,
                                                              ),
                                                            ),
                                                            Text(
                                                              "End Date: ${formatDate(homeDataViewModel.examDetails.value?.responseBody?.first?.endDate) ?? ""}",
                                                              style: TextStyle(
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        800
                                                                    ? 12
                                                                    : MediaQuery.of(context).size.height >
                                                                            700
                                                                        ? 12
                                                                        : MediaQuery.of(context).size.height >
                                                                                650
                                                                            ? 10
                                                                            : MediaQuery.of(context).size.height > 500
                                                                                ? 8
                                                                                : MediaQuery.of(context).size.height > 400
                                                                                    ? 10
                                                                                    : 14,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  spaceWidget(height: 5.0),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    height: widget.isPurchase == 1
                                        ? MediaQuery.of(context).size.height >
                                                800
                                            ? 425
                                            : MediaQuery.of(context)
                                                        .size
                                                        .height >
                                                    700
                                                ? 420
                                                : MediaQuery.of(context)
                                                            .size
                                                            .height >
                                                        650
                                                    ? 400
                                                    : MediaQuery.of(context)
                                                                .size
                                                                .height >
                                                            500
                                                        ? 380
                                                        : MediaQuery.of(context)
                                                                    .size
                                                                    .height >
                                                                400
                                                            ? 380
                                                            : 380
                                        : MediaQuery.of(context).size.height >
                                                800
                                            ? 425
                                            : MediaQuery.of(context)
                                                        .size
                                                        .height >
                                                    700
                                                ? 420
                                                : MediaQuery.of(context)
                                                            .size
                                                            .height >
                                                        650
                                                    ? 400
                                                    : MediaQuery.of(context)
                                                                .size
                                                                .height >
                                                            500
                                                        ? 380
                                                        : MediaQuery.of(context)
                                                                    .size
                                                                    .height >
                                                                400
                                                            ? 330
                                                            : 330,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, top: 10),
                                          child: Table(
                                            columnWidths: const {
                                              0: IntrinsicColumnWidth(), // Adjusts width based on content
                                              1: FlexColumnWidth(), // Adjusts to fill the remaining space
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  const ConstantText(
                                                    text: "Exam Type",
                                                    fontSize: 12.0,
                                                  ),
                                                  ConstantText(
                                                    textAlign: TextAlign.center,
                                                    fontSize: 12.0,
                                                    text: homeDataViewModel
                                                            .examDetails
                                                            .value
                                                            ?.responseBody
                                                            ?.first
                                                            ?.examType ??
                                                        "",
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  spaceWidget(height: 5.0),
                                                  spaceWidget(height: 5.0),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  const ConstantText(
                                                    text: "Difficulty level",
                                                    fontSize: 12.0,
                                                  ),
                                                  ConstantText(
                                                    textAlign: TextAlign.center,
                                                    fontSize: 12.0,
                                                    text: homeDataViewModel
                                                            .examDetails
                                                            .value
                                                            ?.responseBody
                                                            ?.first
                                                            ?.difficultyLevel ??
                                                        "",
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  widget.isPurchase == 1
                                                      ? spaceWidget(height: 5.0)
                                                      : spaceWidget(
                                                          height: 0.0),
                                                  widget.isPurchase == 1
                                                      ? spaceWidget(height: 5.0)
                                                      : spaceWidget(
                                                          height: 0.0),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  widget.isPurchase == 1
                                                      ? ConstantText(
                                                          text: "Opted on",
                                                          fontSize: 12.0,
                                                        )
                                                      : const SizedBox(),
                                                  widget.isPurchase == 1
                                                      ? ConstantText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          fontSize: 12.0,
                                                          text:
                                                              " ${formatDate(homeDataViewModel.examDetails.value?.responseBody?.first?.startDate) ?? ""}",
                                                        )
                                                      : SizedBox()
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  widget.isPurchase == 1
                                                      ? spaceWidget(height: 5.0)
                                                      : spaceWidget(
                                                          height: 0.0),
                                                  widget.isPurchase == 1
                                                      ? spaceWidget(height: 5.0)
                                                      : spaceWidget(
                                                          height: 0.0),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  widget.isPurchase == 1
                                                      ? const ConstantText(
                                                          text: "End Date",
                                                          fontSize: 12.0,
                                                        )
                                                      : SizedBox(),
                                                  widget.isPurchase == 1
                                                      ? ConstantText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          fontSize: 12.0,
                                                          text:
                                                              " ${formatDate(homeDataViewModel.examDetails.value?.responseBody?.first?.endDate) ?? ""}",
                                                        )
                                                      : SizedBox()
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  spaceWidget(height: 5.0),
                                                  spaceWidget(height: 5.0),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  const ConstantText(
                                                    text: "Total questions",
                                                    fontSize: 12.0,
                                                  ),
                                                  ConstantText(
                                                    textAlign: TextAlign.center,
                                                    fontSize: 12.0,
                                                    text: (homeDataViewModel
                                                                .examDetails
                                                                .value
                                                                ?.responseBody
                                                                ?.first
                                                                ?.totalQuestions ??
                                                            300)
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  spaceWidget(height: 5.0),
                                                  spaceWidget(height: 5.0),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  const ConstantText(
                                                    text:
                                                        "Negative marking \nfor unattempted question",
                                                    fontSize: 12.0,
                                                  ),
                                                  ConstantText(
                                                    textAlign: TextAlign.center,
                                                    fontSize: 12.0,
                                                    text: (homeDataViewModel
                                                                .examDetails
                                                                .value
                                                                ?.responseBody
                                                                ?.first
                                                                ?.skipAns ??
                                                            0)
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  spaceWidget(height: 5.0),
                                                  spaceWidget(height: 5.0),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  const ConstantText(
                                                    text:
                                                        "Negative marking \nfor incorrect answer",
                                                    fontSize: 12.0,
                                                  ),
                                                  ConstantText(
                                                    textAlign: TextAlign.center,
                                                    fontSize: 12.0,
                                                    text: (homeDataViewModel
                                                                .examDetails
                                                                .value
                                                                ?.responseBody
                                                                ?.first
                                                                ?.wrongAns ??
                                                            0)
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  spaceWidget(height: 5.0),
                                                  spaceWidget(height: 5.0),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  const ConstantText(
                                                    text:
                                                        "Marks for correct answer",
                                                    fontSize: 12.0,
                                                  ),
                                                  ConstantText(
                                                    textAlign: TextAlign.center,
                                                    fontSize: 12.0,
                                                    maxLines: 2,
                                                    text: (homeDataViewModel
                                                                .examDetails
                                                                .value
                                                                ?.responseBody
                                                                ?.first
                                                                ?.rightAns ??
                                                            0)
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  spaceWidget(height: 5.0),
                                                  spaceWidget(height: 5.0),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  const ConstantText(
                                                    text: "Passing percentage",
                                                    fontSize: 12.0,
                                                  ),
                                                  ConstantText(
                                                    textAlign: TextAlign.center,
                                                    fontSize: 12.0,
                                                    text: (homeDataViewModel
                                                                .examDetails
                                                                .value
                                                                ?.responseBody
                                                                ?.first
                                                                ?.passingPercent ??
                                                            0)
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.13,
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                8.0), // Adding padding to match previous implementation
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                // Assuming each line is approximately 16 pixels in height (for 12.0 font size)
                                                double lineHeight = 16.0;
                                                int maxLinesBeforeScroll = 3;
                                                double maxHeight = lineHeight *
                                                    maxLinesBeforeScroll;

                                                return ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    maxHeight: maxHeight,
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize: MainAxisSize
                                                          .min, // Makes the column take only the space it needs
                                                      children: [
                                                        ConstantText(
                                                          maxLines: 10,
                                                          fontSize: 12.0,
                                                          text: homeDataViewModel
                                                                  .examDetails
                                                                  .value
                                                                  ?.responseBody
                                                                  ?.first
                                                                  ?.examDesc ??
                                                              "",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        spaceWidget(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height >
                                                  800
                                              ? 22
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      700
                                                  ? 12
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          650
                                                      ? 10
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              500
                                                          ? 5
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  400
                                                              ? 10
                                                              : 14,
                                        ),
                                        widget.isPurchase ==
                                                0 // Check if it's home screen to show "Add to Cart" button
                                            ? SizedBox(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    cartViewModel
                                                        .addItem(CartItem(
                                                      title: homeDataViewModel
                                                          .examDetails
                                                          .value
                                                          ?.responseBody
                                                          ?.first
                                                          ?.examName,
                                                      difficulty: homeDataViewModel
                                                              .examDetails
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.difficultyLevel ??
                                                          "",
                                                      exam_code:
                                                          homeDataViewModel
                                                              .examDetails
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.examCode,
                                                      price: homeDataViewModel
                                                          .examDetails
                                                          .value
                                                          ?.responseBody
                                                          ?.first
                                                          ?.price,
                                                      imageUrl:
                                                          homeDataViewModel
                                                              .examDetails
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.img,
                                                    ));
                                                    Get.to(() => CartScreen());
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 15.0,
                                                        horizontal: 100.0),
                                                    backgroundColor:
                                                        Colors.black,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),
                                                    minimumSize:
                                                        const Size(10.0, 30.0),
                                                  ),
                                                  child: const ConstantText(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0,
                                                    text: "Add to cart",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  // examQuestionsViewModel
                                                  //     .isExamScreen.value = true;
                                                  Get.to(() => ExamScreen(
                                                        //  isQuestionScreen: true,
                                                        examCode: homeDataViewModel
                                                                .examDetails
                                                                .value
                                                                ?.responseBody
                                                                ?.first
                                                                ?.examCode ??
                                                            "",
                                                      ));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 100.0),
                                                  backgroundColor: Colors.black,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  minimumSize:
                                                      const Size(10.0, 30.0),
                                                ),
                                                child: const ConstantText(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  text: "Start",
                                                  color: Colors.white,
                                                ),
                                              ),
                                        spaceWidget(height: 20.0)
                                      ],
                                    ),
                                  ),
                                  Container(),
                                ],
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Stack(
                                    children: [
                                      Card(
                                        color: widget.color,
                                        margin:
                                            const EdgeInsets.only(top: 15.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        elevation: 6,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .height >
                                                        800
                                                    ? 120
                                                    : MediaQuery.of(context)
                                                                .size
                                                                .height >
                                                            700
                                                        ? 120
                                                        : MediaQuery.of(context)
                                                                    .size
                                                                    .height >
                                                                650
                                                            ? 100
                                                            : MediaQuery.of(context)
                                                                        .size
                                                                        .height >
                                                                    500
                                                                ? 120
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        400
                                                                    ? 10
                                                                    : 14,
                                                height: MediaQuery.of(context)
                                                            .size
                                                            .height >
                                                        800
                                                    ? 120
                                                    : MediaQuery.of(context)
                                                                .size
                                                                .height >
                                                            700
                                                        ? 120
                                                        : MediaQuery.of(context)
                                                                    .size
                                                                    .height >
                                                                650
                                                            ? 100
                                                            : MediaQuery.of(context)
                                                                        .size
                                                                        .height >
                                                                    500
                                                                ? 80
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        400
                                                                    ? 10
                                                                    : 14,
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(13),
                                                      topLeft:
                                                          Radius.circular(13),
                                                    ),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                      child: homeDataViewModel
                                                                  .examDetails
                                                                  .value
                                                                  ?.responseBody
                                                                  ?.first
                                                                  ?.img !=
                                                              null
                                                          ? Image.network(
                                                              APIConfig
                                                                      .imagePath +
                                                                  (homeDataViewModel
                                                                          .examDetails
                                                                          .value
                                                                          ?.responseBody
                                                                          ?.first
                                                                          ?.img ??
                                                                      ""),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.2,
                                                            )
                                                          : Image.asset(
                                                              'assets/Logo/logo.png',
                                                              fit: BoxFit
                                                                  .contain,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.2,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              " ${homeDataViewModel.examDetails.value?.responseBody?.first?.difficultyLevel ?? ""}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.4),
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        800
                                                                    ? 10
                                                                    : MediaQuery.of(context).size.height >
                                                                            700
                                                                        ? 12
                                                                        : MediaQuery.of(context).size.height >
                                                                                650
                                                                            ? 8
                                                                            : MediaQuery.of(context).size.height > 500
                                                                                ? 8
                                                                                : MediaQuery.of(context).size.height > 400
                                                                                    ? 8
                                                                                    : 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                            Text(
                                                              homeDataViewModel
                                                                          .examDetails
                                                                          .value
                                                                          ?.responseBody
                                                                          ?.first
                                                                          ?.examCode !=
                                                                      null
                                                                  ? "${homeDataViewModel.examDetails.value?.responseBody?.first?.examCode}"
                                                                  : "",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.4),
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        800
                                                                    ? 12
                                                                    : MediaQuery.of(context).size.height >
                                                                            700
                                                                        ? 12
                                                                        : MediaQuery.of(context).size.height >
                                                                                650
                                                                            ? 10
                                                                            : MediaQuery.of(context).size.height > 500
                                                                                ? 8
                                                                                : MediaQuery.of(context).size.height > 400
                                                                                    ? 10
                                                                                    : 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width >
                                                                  600
                                                              ? 10
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .width >
                                                                      300
                                                                  ? 5
                                                                  : 5),
                                                      Text(
                                                        homeDataViewModel
                                                                .examDetails
                                                                .value
                                                                ?.responseBody
                                                                ?.first
                                                                ?.examName ??
                                                            "",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height >
                                                                  800
                                                              ? 17
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      700
                                                                  ? 16
                                                                  : MediaQuery.of(context)
                                                                              .size
                                                                              .height >
                                                                          650
                                                                      ? 14
                                                                      : MediaQuery.of(context).size.height >
                                                                              500
                                                                          ? 13
                                                                          : MediaQuery.of(context).size.height > 400
                                                                              ? 10
                                                                              : 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width >
                                                                600
                                                            ? 6
                                                            : MediaQuery.of(context)
                                                                        .size
                                                                        .width >
                                                                    300
                                                                ? 5
                                                                : 5,
                                                      ),
                                                      (widget.isPurchase == 1)
                                                          ? Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Opted On: ${formatDate(homeDataViewModel.examDetails.value?.responseBody?.first?.startDate) ?? ""}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: MediaQuery.of(context).size.height >
                                                                            800
                                                                        ? 12
                                                                        : MediaQuery.of(context).size.height >
                                                                                700
                                                                            ? 12
                                                                            : MediaQuery.of(context).size.height > 650
                                                                                ? 10
                                                                                : MediaQuery.of(context).size.height > 500
                                                                                    ? 8
                                                                                    : MediaQuery.of(context).size.height > 400
                                                                                        ? 10
                                                                                        : 14,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "End Date: ${formatDate(homeDataViewModel.examDetails.value?.responseBody?.first?.endDate) ?? ""}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: MediaQuery.of(context).size.height >
                                                                            800
                                                                        ? 12
                                                                        : MediaQuery.of(context).size.height >
                                                                                700
                                                                            ? 12
                                                                            : MediaQuery.of(context).size.height > 650
                                                                                ? 10
                                                                                : MediaQuery.of(context).size.height > 500
                                                                                    ? 8
                                                                                    : MediaQuery.of(context).size.height > 400
                                                                                        ? 10
                                                                                        : 14,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                spaceWidget(height: 5.0),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  height: widget.isPurchase == 1
                                      ? MediaQuery.of(context).size.height > 800
                                          ? 460
                                          : MediaQuery.of(context).size.height >
                                                  700
                                              ? 405
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      650
                                                  ? 400
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          500
                                                      ? 340
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              400
                                                          ? 350
                                                          : 300
                                      : MediaQuery.of(context).size.height > 800
                                          ? 430
                                          : MediaQuery.of(context).size.height >
                                                  700
                                              ? 400
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      650
                                                  ? 400
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          500
                                                      ? 300
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              400
                                                          ? 350
                                                          : 300,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, top: 10),
                                        child: Table(
                                          columnWidths: const {
                                            0: IntrinsicColumnWidth(
                                                flex:
                                                    1.5), // Adjusts width based on content
                                            1: FlexColumnWidth(), // Adjusts to fill the remaining space
                                          },
                                          children: [
                                            TableRow(
                                              children: [
                                                const ConstantText(
                                                  text: "Exam Type",
                                                  fontSize: 12.0,
                                                ),
                                                ConstantText(
                                                  textAlign: TextAlign.start,
                                                  fontSize: 12.0,
                                                  text: homeDataViewModel
                                                          .examDetails
                                                          .value
                                                          ?.responseBody
                                                          ?.first
                                                          ?.examType ??
                                                      "",
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                spaceWidget(height: 7.0),
                                                spaceWidget(height: 7.0),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                const ConstantText(
                                                  text: "Difficulty level",
                                                  fontSize: 12.0,
                                                ),
                                                ConstantText(
                                                  textAlign: TextAlign.start,
                                                  fontSize: 12.0,
                                                  text: homeDataViewModel
                                                          .examDetails
                                                          .value
                                                          ?.responseBody
                                                          ?.first
                                                          ?.difficultyLevel ??
                                                      "",
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                widget.isPurchase == 1
                                                    ? spaceWidget(height: 7.0)
                                                    : spaceWidget(height: 0.0),
                                                widget.isPurchase == 1
                                                    ? spaceWidget(height: 7.0)
                                                    : spaceWidget(height: 0.0),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                widget.isPurchase == 1
                                                    ? ConstantText(
                                                        text: "Opted on",
                                                        fontSize: 12.0,
                                                      )
                                                    : const SizedBox(),
                                                widget.isPurchase == 1
                                                    ? ConstantText(
                                                        textAlign:
                                                            TextAlign.start,
                                                        fontSize: 12.0,
                                                        text:
                                                            " ${formatDate(homeDataViewModel.examDetails.value?.responseBody?.first?.startDate) ?? ""}",
                                                      )
                                                    : SizedBox()
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                widget.isPurchase == 1
                                                    ? spaceWidget(height: 7.0)
                                                    : spaceWidget(height: 0.0),
                                                widget.isPurchase == 1
                                                    ? spaceWidget(height: 7.0)
                                                    : spaceWidget(height: 0.0),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                widget.isPurchase == 1
                                                    ? const ConstantText(
                                                        text: "End Date",
                                                        fontSize: 12.0,
                                                      )
                                                    : SizedBox(),
                                                widget.isPurchase == 1
                                                    ? ConstantText(
                                                        textAlign:
                                                            TextAlign.start,
                                                        fontSize: 12.0,
                                                        text:
                                                            " ${formatDate(homeDataViewModel.examDetails.value?.responseBody?.first?.endDate) ?? ""}",
                                                      )
                                                    : SizedBox()
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                spaceWidget(height: 7.0),
                                                spaceWidget(height: 7.0),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                const ConstantText(
                                                  text: "Total questions",
                                                  fontSize: 12.0,
                                                ),
                                                ConstantText(
                                                  textAlign: TextAlign.start,
                                                  fontSize: 12.0,
                                                  text: (homeDataViewModel
                                                              .examDetails
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.totalQuestions ??
                                                          300)
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                spaceWidget(height: 7.0),
                                                spaceWidget(height: 7.0),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                const ConstantText(
                                                  text:
                                                      "Marks for correct answer",
                                                  fontSize: 12.0,
                                                ),
                                                ConstantText(
                                                  textAlign: TextAlign.start,
                                                  fontSize: 12.0,
                                                  maxLines: 2,
                                                  text: (homeDataViewModel
                                                              .examDetails
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.rightAns ??
                                                          0)
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                spaceWidget(height: 7.0),
                                                spaceWidget(height: 7.0),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                const ConstantText(
                                                  text:
                                                      "Negative marking \nfor unattempted question",
                                                  fontSize: 12.0,
                                                ),
                                                ConstantText(
                                                  textAlign: TextAlign.start,
                                                  fontSize: 12.0,
                                                  text: (homeDataViewModel
                                                              .examDetails
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.skipAns ??
                                                          0)
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                spaceWidget(height: 7.0),
                                                spaceWidget(height: 7.0),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                const ConstantText(
                                                  text:
                                                      "Negative marking \nfor incorrect answer",
                                                  fontSize: 12.0,
                                                ),
                                                ConstantText(
                                                  textAlign: TextAlign.start,
                                                  fontSize: 12.0,
                                                  text: (homeDataViewModel
                                                              .examDetails
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.wrongAns ??
                                                          0)
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                spaceWidget(height: 7.0),
                                                spaceWidget(height: 7.0),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                const ConstantText(
                                                  text: "Passing percentage",
                                                  fontSize: 12.0,
                                                ),
                                                ConstantText(
                                                  textAlign: TextAlign.start,
                                                  fontSize: 12.0,
                                                  text: (homeDataViewModel
                                                              .examDetails
                                                              .value
                                                              ?.responseBody
                                                              ?.first
                                                              ?.passingPercent ??
                                                          0)
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                spaceWidget(height: 7.0),
                                                spaceWidget(height: 7.0),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context)
                                                    .size
                                                    .height >
                                                800
                                            ? 100
                                            : MediaQuery.of(context)
                                                        .size
                                                        .height >
                                                    700
                                                ? 80
                                                : MediaQuery.of(context)
                                                            .size
                                                            .height >
                                                        650
                                                    ? 60
                                                    : MediaQuery.of(context)
                                                                .size
                                                                .height >
                                                            500
                                                        ? 40
                                                        : MediaQuery.of(context)
                                                                    .size
                                                                    .height >
                                                                400
                                                            ? 35
                                                            : 30,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              8.0), // Adding padding to match previous implementation
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              // Assuming each line is approximately 16 pixels in height (for 12.0 font size)
                                              double lineHeight = 16.0;
                                              int maxLinesBeforeScroll = 3;
                                              double maxHeight = lineHeight *
                                                  maxLinesBeforeScroll;

                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10),
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    maxHeight: maxHeight,
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize: MainAxisSize
                                                          .min, // Makes the column take only the space it needs
                                                      children: [
                                                        ConstantText(
                                                          maxLines: 10,
                                                          fontSize: 12.0,
                                                          text: homeDataViewModel
                                                                  .examDetails
                                                                  .value
                                                                  ?.responseBody
                                                                  ?.first
                                                                  ?.examDesc ??
                                                              "",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      spaceWidget(
                                          height: widget.isPurchase == 1
                                              ? MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      800
                                                  ? 10
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          700
                                                      ? 10
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              650
                                                          ? 7
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  500
                                                              ? 7
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      400
                                                                  ? 5
                                                                  : 5
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      800
                                                  ? 25
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          700
                                                      ? 25
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              650
                                                          ? 23
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  500
                                                              ? 23
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      400
                                                                  ? 21
                                                                  : 21),
                                      homeDataViewModel
                                                  .examDetails
                                                  .value
                                                  ?.responseBody
                                                  ?.first
                                                  ?.isPurchase ==
                                              0
                                          ? SizedBox(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  cartViewModel
                                                      .addItem(CartItem(
                                                    title: homeDataViewModel
                                                        .examDetails
                                                        .value
                                                        ?.responseBody
                                                        ?.first
                                                        ?.examName,
                                                    difficulty: homeDataViewModel
                                                            .examDetails
                                                            .value
                                                            ?.responseBody
                                                            ?.first
                                                            ?.difficultyLevel ??
                                                        "",
                                                    exam_code: homeDataViewModel
                                                        .examDetails
                                                        .value
                                                        ?.responseBody
                                                        ?.first
                                                        ?.examCode,
                                                    price: homeDataViewModel
                                                        .examDetails
                                                        .value
                                                        ?.responseBody
                                                        ?.first
                                                        ?.price,
                                                    imageUrl: homeDataViewModel
                                                        .examDetails
                                                        .value
                                                        ?.responseBody
                                                        ?.first
                                                        ?.img,
                                                  ));
                                                  Get.to(() => CartScreen());
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 100.0),
                                                  backgroundColor: Colors.black,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  minimumSize:
                                                      const Size(10.0, 30.0),
                                                ),
                                                child: const ConstantText(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  text: "Add to cart",
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                showLoadingDialog();
                                                homeDataViewModel
                                                    .getExamDetails(
                                                        examCode:
                                                            widget.examCode);
                                                hideLoadingDialog();
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
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
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          10.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "${widget.examCode}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          10.0,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Text(homeDataViewModel
                                                                      .examDetails
                                                                      .value
                                                                      ?.responseBody
                                                                      ?.first
                                                                      ?.examName ??
                                                                  ""),
                                                            ],
                                                          ),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Row(
                                                              //   mainAxisAlignment:
                                                              //       MainAxisAlignment
                                                              //           .spaceBetween,
                                                              //   children: [
                                                              //     const ConstantText(
                                                              //         text:
                                                              //             "Exam Type"),
                                                              //     ConstantText(
                                                              //         text: homeDataViewModel
                                                              //                 .examDetails
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
                                                                      text: (homeDataViewModel
                                                                          .examDetails
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
                                                                      text:
                                                                          "Total Marks"),
                                                                  ConstantText(
                                                                      text: (homeDataViewModel
                                                                          .examDetails
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
                                                                      text:
                                                                          "Duration"),
                                                                  ConstantText(
                                                                      text: (homeDataViewModel
                                                                          .examDetails
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
                                                                      text:
                                                                          "Exam Type"),
                                                                  ConstantText(
                                                                      text: homeDataViewModel
                                                                              .examDetails
                                                                              .value
                                                                              ?.responseBody
                                                                              ?.first
                                                                              ?.examType ??
                                                                          "")
                                                                ],
                                                              ),
                                                              Divider(),
                                                              ConstantText(
                                                                  text: (homeDataViewModel
                                                                      .examDetails
                                                                      .value
                                                                      ?.responseBody
                                                                      ?.first
                                                                      ?.examDesc)),
                                                              spaceWidget(
                                                                  height: 20.0),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Get.to(() =>
                                                                      ExamScreen(
                                                                        // isQuestionScreen: true,
                                                                        examCode:
                                                                            homeDataViewModel.examDetails.value?.responseBody?.first?.examCode ??
                                                                                "",
                                                                      ));
                                                                  // Navigator.of(
                                                                  //         context)
                                                                  //     .push(
                                                                  //         MaterialPageRoute(
                                                                  //   builder:
                                                                  //       (context) =>
                                                                  //           ExamScreen(
                                                                  //     examCode:
                                                                  //         widget.examCode ??
                                                                  //             "",
                                                                  //   ),
                                                                  // ))
                                                                  //     .then(
                                                                  //         (_) {
                                                                  //   // Reset state after navigation is complete
                                                                  //   // examQuestionsViewModel
                                                                  //   //     .isExamScreen.value = false;
                                                                  // });
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          25.0),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(15)),
                                                                  ),
                                                                  minimumSize:
                                                                      const Size(
                                                                          10.0,
                                                                          30.0),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "Start",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                                    });

                                                // examQuestionsViewModel
                                                //     .isExamScreen.value = true;
                                                // Get.to(() => ExamScreen(
                                                //       // isQuestionScreen: true,
                                                //       examCode:
                                                //           homeDataViewModel
                                                //                   .examDetails
                                                //                   .value
                                                //                   ?.responseBody
                                                //                   ?.first
                                                //                   ?.examCode ??
                                                //               "",
                                                //     ));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15.0,
                                                        horizontal: 100.0),
                                                backgroundColor: Colors.black,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                minimumSize:
                                                    const Size(10.0, 20.0),
                                              ),
                                              child: const ConstantText(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                text: "Start",
                                                color: Colors.white,
                                              ),
                                            ),
                                      spaceWidget(height: 0.0)
                                    ],
                                  ),
                                ),
                                Container(),
                              ],
                            ),
                    ),
                  ],
                ),
                bottomNavigationBar:
                    bottomBarVisibility ? CustomBottomNavBar() : null,
              );
            }),
          ),
        );
      },
    );
  }
}
