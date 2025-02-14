import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/score_history/model/score_history_data_model.dart';
import 'package:indrayani/module/score_history/view_model/score_history_view_model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/custom_bottom_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
import 'package:intl/intl.dart';

class ScoreHistoryScreen extends StatefulWidget {
  ScoreHistoryScreen({Key? key}) : super(key: key);

  @override
  _ScoreHistoryScreenState createState() => _ScoreHistoryScreenState();
}

class _ScoreHistoryScreenState extends State<ScoreHistoryScreen> {
  final ScoreHistoryViewModel scoreHistoryViewModel =
      Get.put(ScoreHistoryViewModel());
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> getStaticData() {
    return [
      {
        "examId": "1",
        "examCode": "JE01",
        "examName": "JEE",
        "userScore": "1200",
        "attemptDate&Time": "2025-02-23",
        "percentage": "85%"
      },
      {
        "examId": "2",
        "examCode": "NE01",
        "examName": "NEET",
        "userScore": "1000",
        "attemptDate&Time": "2025-02-23",
        "percentage": "80%"
      },
      {
        "examId": "3",
        "examCode": "MH01",
        "examName": "MHCET",
        "userScore": "1000",
        "attemptDate&Time": "2025-02-23",
        "percentage": "75%"
      },
      {
        "examId": "4",
        "examCode": "PSI01",
        "examName": "PSI",
        "userScore": "1000",
        "attemptDate&Time": "2025-02-23",
        "percentage": "78%"
      },
      {
        "examId": "5",
        "examCode": "NIT01",
        "examName": "NIT",
        "userScore": "1000",
        "attemptDate&Time": "2025-02-23",
        "percentage": "82%"
      },
      {
        "examId": "6",
        "examCode": "SCI01",
        "examName": "SCI",
        "userScore": "1000",
        "attemptDate&Time": "2025-02-23",
        "percentage": "79%"
      },
      {
        "examId": "7",
        "examCode": "JET01",
        "examName": "JET",
        "userScore": "1000",
        "attemptDate&Time": "2025-02-23",
        "percentage": "81%"
      },
      {
        "examId": "8",
        "examCode": "GATE01",
        "examName": "GATE",
        "userScore": "1000",
        "attemptDate&Time": "2025-02-23",
        "percentage": "83%"
      },
      {
        "examId": "9",
        "examCode": "MAT01",
        "examName": "MAT",
        "userScore": "1000",
        "attemptDate&Time": "2025-02-23",
        "percentage": "77%"
      },
      {
        "examId": "10",
        "examCode": "CAT01",
        "examName": "CAT",
        "userScore": "1000",
        "attemptDate&Time": "2025-02-23",
        "percentage": "84%"
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showLoadingDialog();
      await scoreHistoryViewModel.fetchScoreHistoryList();
      hideLoadingDialog();
      scoreHistoryViewModel.filteredScoreExamModels.value =
          scoreHistoryViewModel.scoreHistoryExamModels.value;
    });
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(
      () {
        final bottomBarVisibility =
            Get.find<NavigationController>().showBottomBar.value;
        return SafeArea(
          child: Scaffold(
            backgroundColor: bodyBGColor,
            appBar: const CustomAppBar(
              containerText: "Score History",
              imagePath: "assets/Score_History/icon.png",
            ),
            drawer: const UserDrawer(),
            body: Container(
              child: MediaQuery.of(context).orientation == Orientation.portrait
                  ? Stack(
                      children: [
                        CustomPaint(
                          painter: HeaderCurvedContainer(),
                          child: SizedBox(
                            width: screenWidth,
                            height: screenHeight,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.05,
                            top: screenHeight * 0.02,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Exam Attempt List",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.05,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                            horizontal: screenWidth * 0.04,
                          ),
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    height: screenHeight * 0.05,
                                    width: screenWidth * 0.80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 1),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _searchController,
                                            onChanged: (value) {
                                              scoreHistoryViewModel
                                                  .searchExams(value);
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "All",
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                              hintStyle: TextStyle(
                                                fontSize:
                                                    13.0, // Set your desired font size here
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height >
                                                  800
                                              ? 45
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      700
                                                  ? 45
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          650
                                                      ? 40
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              500
                                                          ? 40
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  400
                                                              ? 37
                                                              : 37,
                                          color: const Color.fromARGB(
                                              255, 10, 34, 100),
                                          child: IconButton(
                                            icon: const Icon(Icons.search),
                                            color: Colors.white,
                                            onPressed: () {
                                              scoreHistoryViewModel.searchExams(
                                                  _searchController.text);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.01),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
                                    color: Colors.grey[300],
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.01),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Exam',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      800
                                                  ? 16
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          700
                                                      ? 14
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              650
                                                          ? 14
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  500
                                                              ? 12
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      400
                                                                  ? 12
                                                                  : 12,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .height >
                                                    800
                                                ? 2
                                                : MediaQuery.of(context)
                                                            .size
                                                            .height >
                                                        700
                                                    ? 2
                                                    : MediaQuery.of(context)
                                                                .size
                                                                .height >
                                                            650
                                                        ? 2
                                                        : MediaQuery.of(context)
                                                                    .size
                                                                    .height >
                                                                500
                                                            ? 2
                                                            : MediaQuery.of(context)
                                                                        .size
                                                                        .height >
                                                                    400
                                                                ? 2
                                                                : 2,
                                          ),
                                          Text(
                                            'User Score',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      800
                                                  ? 16
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          700
                                                      ? 14
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              650
                                                          ? 14
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  500
                                                              ? 12
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      400
                                                                  ? 12
                                                                  : 12,
                                            ),
                                          ),
                                          // const SizedBox(width: 20),
                                          Text(
                                            'Date & Time',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      800
                                                  ? 16
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          700
                                                      ? 14
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              650
                                                          ? 14
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  500
                                                              ? 12
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      400
                                                                  ? 12
                                                                  : 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Obx(() {
                                    final scoreHistory = scoreHistoryViewModel
                                        .filteredScoreExamModels.value;
                                    if (scoreHistory == null) {
                                      return Center(
                                        child: Animate(
                                          child: const ConstantText(
                                            text: "No Exams found!",
                                          )
                                              .animate()
                                              .fadeIn(duration: 600.ms)
                                              .then(delay: 200.ms)
                                              .slide(),
                                        ),
                                      );
                                    } else {
                                      final List<ScoreHistoryDataModel?> exams =
                                          scoreHistory;
                                      return ListView.builder(
                                        itemCount: exams.length,
                                        itemBuilder: (context, index) {
                                          final exam = exams[index];
                                          final int score = exam?.score ?? 0;
                                          double? scorePercentage =
                                              double.tryParse(
                                                  exam?.percentageScore ??
                                                      "0.0");
                                          String formattedDateTime = '';
                                          if (exam?.attemptedAt != null) {
                                            try {
                                              final dateTime = DateTime.parse(
                                                  exam?.attemptedAt ?? '');

                                              // Convert the parsed date to IST (Indian Standard Time)
                                              final istTime = dateTime
                                                  .toUtc()
                                                  .add(Duration(
                                                      hours: 5, minutes: 30));

                                              formattedDateTime =
                                                  DateFormat('dd-MM-yyyy HH:mm')
                                                      .format(istTime);
                                            } catch (e) {
                                              formattedDateTime =
                                                  'Invalid date';
                                            }
                                          }
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.01,
                                              horizontal: MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      800
                                                  ? 20
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          700
                                                      ? 20
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              650
                                                          ? 20
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  500
                                                              ? 19
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      400
                                                                  ? 19
                                                                  : 37,
                                            ),
                                            child: Container(
                                              height: screenHeight * 0.10,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: (score >=
                                                        (exam?.passingMarks ??
                                                            0))
                                                    ? const Color.fromARGB(
                                                        255, 221, 255, 222)
                                                    : const Color.fromARGB(
                                                        255, 255, 207, 203),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 6.0,
                                                            right: 6.0,
                                                            top: 10.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          exam?.examCode ?? '',
                                                          style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 11
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 10
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 10
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 8
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 8
                                                                                : 10,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                        Text(
                                                          formattedDateTime,
                                                          style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 13
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 10
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 10
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 8
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 12
                                                                                : 12,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4.0,
                                                            right: 3.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height >
                                                                  800
                                                              ? 100
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      700
                                                                  ? 100
                                                                  : MediaQuery.of(context)
                                                                              .size
                                                                              .height >
                                                                          650
                                                                      ? 100
                                                                      : MediaQuery.of(context).size.height >
                                                                              500
                                                                          ? 90
                                                                          : MediaQuery.of(context).size.height > 400
                                                                              ? 90
                                                                              : 90,
                                                          child: Text(
                                                            exam?.examName ??
                                                                '',
                                                            style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height >
                                                                      800
                                                                  ? 14
                                                                  : MediaQuery.of(context)
                                                                              .size
                                                                              .height >
                                                                          700
                                                                      ? 14
                                                                      : MediaQuery.of(context).size.height >
                                                                              650
                                                                          ? 12
                                                                          : MediaQuery.of(context).size.height > 500
                                                                              ? 10
                                                                              : MediaQuery.of(context).size.height > 400
                                                                                  ? 9
                                                                                  : 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                            // maxLines: (exam?.examName
                                                            //                 ?.split(' ')
                                                            //                 .length ??
                                                            //             0) >
                                                            //         8
                                                            //     ? 2
                                                            //     : 1,
                                                            // softWrap: true,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${score.toString()}/${exam?.totalMarks ?? 0}",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 16
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 14
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 14
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 10
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 10
                                                                                : 10,
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                        ),
                                                        Card(
                                                          elevation: 3,
                                                          color: (scorePercentage !=
                                                                      null &&
                                                                  scorePercentage >=
                                                                      (exam?.passingPercent ??
                                                                          0))
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  188, 240, 139)
                                                              : Colors.red,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 96
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 80
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 92
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 92
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 89
                                                                                : 100,
                                                            height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 34
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 28
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 30
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 30
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 30
                                                                                : 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .transparent,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.1),
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                  blurRadius: 4,
                                                                  spreadRadius:
                                                                      1,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${scorePercentage ?? ''}%',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height >
                                                                          800
                                                                      ? 16
                                                                      : MediaQuery.of(context).size.height >
                                                                              700
                                                                          ? 14
                                                                          : MediaQuery.of(context).size.height > 650
                                                                              ? 14
                                                                              : MediaQuery.of(context).size.height > 500
                                                                                  ? 12
                                                                                  : MediaQuery.of(context).size.height > 400
                                                                                      ? 12
                                                                                      : 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // child: ListTile(
                                              //   contentPadding: EdgeInsets.zero,
                                              //   leading: Padding(
                                              //     padding: const EdgeInsets.all(2.0),
                                              //     child: Row(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment.spaceBetween,
                                              //       children: [
                                              //         SizedBox(
                                              //           width: MediaQuery.of(context)
                                              //                   .size
                                              //                   .width *
                                              //               0.3,
                                              //           child: Column(
                                              //             crossAxisAlignment:
                                              //                 CrossAxisAlignment.start,
                                              //             children: [
                                              //               Text(
                                              //                 exam?.examCode ?? '',
                                              //                 style: TextStyle(
                                              //                   fontSize: MediaQuery.of(
                                              //                                   context)
                                              //                               .size
                                              //                               .height >
                                              //                           800
                                              //                       ? 11
                                              //                       : MediaQuery.of(context)
                                              //                                   .size
                                              //                                   .height >
                                              //                               700
                                              //                           ? 10
                                              //                           : MediaQuery.of(context)
                                              //                                       .size
                                              //                                       .height >
                                              //                                   650
                                              //                               ? 10
                                              //                               : MediaQuery.of(context).size.height >
                                              //                                       500
                                              //                                   ? 8
                                              //                                   : MediaQuery.of(context).size.height >
                                              //                                           400
                                              //                                       ? 8
                                              //                                       : 10,
                                              //                   color: Colors.black54,
                                              //                 ),
                                              //               ),
                                              //               const SizedBox(height: 8),
                                              //               Text(
                                              //                 exam?.examName ?? '',
                                              //                 style: TextStyle(
                                              //                   fontSize: MediaQuery.of(
                                              //                                   context)
                                              //                               .size
                                              //                               .height >
                                              //                           800
                                              //                       ? 14
                                              //                       : MediaQuery.of(context)
                                              //                                   .size
                                              //                                   .height >
                                              //                               700
                                              //                           ? 14
                                              //                           : MediaQuery.of(context)
                                              //                                       .size
                                              //                                       .height >
                                              //                                   650
                                              //                               ? 12
                                              //                               : MediaQuery.of(context).size.height >
                                              //                                       500
                                              //                                   ? 12
                                              //                                   : MediaQuery.of(context).size.height >
                                              //                                           400
                                              //                                       ? 12
                                              //                                       : 12,
                                              //                   fontWeight:
                                              //                       FontWeight.bold,
                                              //                   color: Colors.black54,
                                              //                 ),
                                              //                 maxLines: (exam?.examName
                                              //                                 ?.split(
                                              //                                     ' ')
                                              //                                 .length ??
                                              //                             0) >
                                              //                         8
                                              //                     ? 2
                                              //                     : 1,
                                              //                 softWrap: true,
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ),
                                              //         // ConstantText(
                                              //         //   text:
                                              //         //       "${score.toString()}/${exam?.totalMarks ?? 0}",
                                              //         //   style: TextStyle(
                                              //         //     fontSize: MediaQuery.of(
                                              //         //                     context)
                                              //         //                 .size
                                              //         //                 .height >
                                              //         //             800
                                              //         //         ? 16
                                              //         //         : MediaQuery.of(context)
                                              //         //                     .size
                                              //         //                     .height >
                                              //         //                 700
                                              //         //             ? 14
                                              //         //             : MediaQuery.of(context)
                                              //         //                         .size
                                              //         //                         .height >
                                              //         //                     650
                                              //         //                 ? 14
                                              //         //                 : MediaQuery.of(context)
                                              //         //                             .size
                                              //         //                             .height >
                                              //         //                         500
                                              //         //                     ? 12
                                              //         //                     : MediaQuery.of(context)
                                              //         //                                 .size
                                              //         //                                 .height >
                                              //         //                             400
                                              //         //                         ? 12
                                              //         //                         : 12,
                                              //         //     color: Colors.black87,
                                              //         //   ),
                                              //         // ),
                                              //         // Column(
                                              //         //   crossAxisAlignment:
                                              //         //       CrossAxisAlignment.start,
                                              //         //   children: [
                                              //         //     Text(
                                              //         //       formattedDateTime,
                                              //         //       style: TextStyle(
                                              //         //         fontSize: MediaQuery.of(
                                              //         //                         context)
                                              //         //                     .size
                                              //         //                     .height >
                                              //         //                 800
                                              //         //             ? 13
                                              //         //             : MediaQuery.of(context)
                                              //         //                         .size
                                              //         //                         .height >
                                              //         //                     700
                                              //         //                 ? 10
                                              //         //                 : MediaQuery.of(context)
                                              //         //                             .size
                                              //         //                             .height >
                                              //         //                         650
                                              //         //                     ? 14
                                              //         //                     : MediaQuery.of(context)
                                              //         //                                 .size
                                              //         //                                 .height >
                                              //         //                             500
                                              //         //                         ? 12
                                              //         //                         : MediaQuery.of(context).size.height >
                                              //         //                                 400
                                              //         //                             ? 12
                                              //         //                             : 12,
                                              //         //         color: Colors.black54,
                                              //         //       ),
                                              //         //     ),
                                              //         //     Card(
                                              //         //       elevation: 3,
                                              //         //       color: (scorePercentage !=
                                              //         //                   null &&
                                              //         //               scorePercentage >
                                              //         //                   (exam?.passingPercent ??
                                              //         //                       0))
                                              //         //           ? const Color.fromARGB(
                                              //         //               255, 188, 240, 139)
                                              //         //           : Colors.red,
                                              //         //       shape:
                                              //         //           RoundedRectangleBorder(
                                              //         //         borderRadius:
                                              //         //             BorderRadius.circular(
                                              //         //                 8),
                                              //         //       ),
                                              //         //       child: Container(
                                              //         //         width: MediaQuery.of(
                                              //         //                         context)
                                              //         //                     .size
                                              //         //                     .height >
                                              //         //                 800
                                              //         //             ? 96
                                              //         //             : MediaQuery.of(context)
                                              //         //                         .size
                                              //         //                         .height >
                                              //         //                     700
                                              //         //                 ? 80
                                              //         //                 : MediaQuery.of(context)
                                              //         //                             .size
                                              //         //                             .height >
                                              //         //                         650
                                              //         //                     ? 92
                                              //         //                     : MediaQuery.of(context)
                                              //         //                                 .size
                                              //         //                                 .height >
                                              //         //                             500
                                              //         //                         ? 92
                                              //         //                         : MediaQuery.of(context).size.height >
                                              //         //                                 400
                                              //         //                             ? 89
                                              //         //                             : 100,
                                              //         //         height: MediaQuery.of(
                                              //         //                         context)
                                              //         //                     .size
                                              //         //                     .height >
                                              //         //                 800
                                              //         //             ? 34
                                              //         //             : MediaQuery.of(context)
                                              //         //                         .size
                                              //         //                         .height >
                                              //         //                     700
                                              //         //                 ? 28
                                              //         //                 : MediaQuery.of(context)
                                              //         //                             .size
                                              //         //                             .height >
                                              //         //                         650
                                              //         //                     ? 30
                                              //         //                     : MediaQuery.of(context)
                                              //         //                                 .size
                                              //         //                                 .height >
                                              //         //                             500
                                              //         //                         ? 30
                                              //         //                         : MediaQuery.of(context).size.height >
                                              //         //                                 400
                                              //         //                             ? 30
                                              //         //                             : 20,
                                              //         //         decoration: BoxDecoration(
                                              //         //           color:
                                              //         //               Colors.transparent,
                                              //         //           borderRadius:
                                              //         //               BorderRadius
                                              //         //                   .circular(8),
                                              //         //           boxShadow: [
                                              //         //             BoxShadow(
                                              //         //               color: Colors.black
                                              //         //                   .withOpacity(
                                              //         //                       0.1),
                                              //         //               offset:
                                              //         //                   const Offset(
                                              //         //                       0, 2),
                                              //         //               blurRadius: 4,
                                              //         //               spreadRadius: 1,
                                              //         //             ),
                                              //         //           ],
                                              //         //         ),
                                              //         //         child: Center(
                                              //         //           child: Text(
                                              //         //             '${scorePercentage ?? ''}%',
                                              //         //             style: TextStyle(
                                              //         //               fontWeight:
                                              //         //                   FontWeight.bold,
                                              //         //               fontSize: MediaQuery.of(
                                              //         //                               context)
                                              //         //                           .size
                                              //         //                           .height >
                                              //         //                       800
                                              //         //                   ? 16
                                              //         //                   : MediaQuery.of(context)
                                              //         //                               .size
                                              //         //                               .height >
                                              //         //                           700
                                              //         //                       ? 14
                                              //         //                       : MediaQuery.of(context).size.height >
                                              //         //                               650
                                              //         //                           ? 14
                                              //         //                           : MediaQuery.of(context).size.height >
                                              //         //                                   500
                                              //         //                               ? 12
                                              //         //                               : MediaQuery.of(context).size.height > 400
                                              //         //                                   ? 12
                                              //         //                                   : 12,
                                              //         //             ),
                                              //         //           ),
                                              //         //         ),
                                              //         //       ),
                                              //         //     ),
                                              //         //   ],
                                              //         // ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        CustomPaint(
                          painter: HeaderCurvedContainer(),
                          child: SizedBox(
                            width: screenWidth,
                            height: screenHeight,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.05,
                            top: screenHeight * 0.02,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Exam Attempt List",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.05,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                            horizontal: screenWidth * 0.04,
                          ),
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.02),
                                  child: Container(
                                    height: screenHeight * 0.1,
                                    width: screenWidth * 0.80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 1),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _searchController,
                                            onChanged: (value) {
                                              scoreHistoryViewModel
                                                  .searchExams(value);
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "All",
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(left: 10),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height >
                                                  800
                                              ? 45
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      700
                                                  ? 45
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          650
                                                      ? 40
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              500
                                                          ? 40
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  400
                                                              ? 37
                                                              : 37,
                                          color: const Color.fromARGB(
                                              255, 10, 34, 100),
                                          child: IconButton(
                                            icon: const Icon(Icons.search),
                                            color: Colors.white,
                                            onPressed: () {
                                              scoreHistoryViewModel.searchExams(
                                                  _searchController.text);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.01),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
                                    color: Colors.grey[300],
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.01),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Exam',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      800
                                                  ? 16
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          700
                                                      ? 14
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              650
                                                          ? 14
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  500
                                                              ? 12
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      400
                                                                  ? 12
                                                                  : 12,
                                            ),
                                          ),

                                          Text(
                                            'User Score',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      800
                                                  ? 16
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          700
                                                      ? 14
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              650
                                                          ? 14
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  500
                                                              ? 12
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      400
                                                                  ? 12
                                                                  : 12,
                                            ),
                                          ),
                                          // const SizedBox(width: 20),
                                          Text(
                                            'Date & Time',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      800
                                                  ? 16
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          700
                                                      ? 14
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              650
                                                          ? 14
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  500
                                                              ? 12
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      400
                                                                  ? 12
                                                                  : 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Obx(() {
                                    final scoreHistory = scoreHistoryViewModel
                                        .filteredScoreExamModels.value;
                                    if (scoreHistory == null) {
                                      return Center(
                                        child: Animate(
                                          child: const ConstantText(
                                            text: "No Exams found!",
                                          )
                                              .animate()
                                              .fadeIn(duration: 600.ms)
                                              .then(delay: 200.ms)
                                              .slide(),
                                        ),
                                      );
                                    } else {
                                      final List<ScoreHistoryDataModel?> exams =
                                          scoreHistory;
                                      return ListView.builder(
                                        itemCount: exams.length,
                                        itemBuilder: (context, index) {
                                          final exam = exams[index];
                                          final int score = exam?.score ?? 0;
                                          double? scorePercentage =
                                              double.tryParse(
                                                  exam?.percentageScore ??
                                                      "0.0");
                                          String formattedDateTime = '';
                                          if (exam?.attemptedAt != null) {
                                            try {
                                              final dateTime = DateTime.parse(
                                                  exam?.attemptedAt ?? '');

                                              // Convert the parsed date to IST (Indian Standard Time)
                                              final istTime = dateTime
                                                  .toUtc()
                                                  .add(Duration(
                                                      hours: 5, minutes: 30));

                                              formattedDateTime =
                                                  DateFormat('dd-MM-yyyy HH:mm')
                                                      .format(istTime);
                                            } catch (e) {
                                              formattedDateTime =
                                                  'Invalid date';
                                            }
                                          }
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.01,
                                              horizontal: MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      800
                                                  ? 37
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          700
                                                      ? 37
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              650
                                                          ? 37
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .height >
                                                                  500
                                                              ? 37
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      400
                                                                  ? 35
                                                                  : 35,
                                            ),
                                            child: Container(
                                              height: screenHeight * 0.20,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: (score >=
                                                        (exam?.passingMarks ??
                                                            0))
                                                    ? const Color.fromARGB(
                                                        255, 221, 255, 222)
                                                    : const Color.fromARGB(
                                                        255, 255, 207, 203),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 6.0,
                                                            right: 6.0,
                                                            top: 10.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          exam?.examCode ?? '',
                                                          style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 11
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 10
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 10
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 8
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 8
                                                                                : 10,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                        Text(
                                                          formattedDateTime,
                                                          style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 13
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 10
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 10
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 8
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 12
                                                                                : 12,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0,
                                                            right: 3.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height >
                                                                  800
                                                              ? 100
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .height >
                                                                      700
                                                                  ? 100
                                                                  : MediaQuery.of(context)
                                                                              .size
                                                                              .height >
                                                                          650
                                                                      ? 28
                                                                      : MediaQuery.of(context).size.height >
                                                                              500
                                                                          ? 28
                                                                          : MediaQuery.of(context).size.height > 400
                                                                              ? 35
                                                                              : 85,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 4.0),
                                                            child: Text(
                                                              exam?.examName ??
                                                                  '',
                                                              style: TextStyle(
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        800
                                                                    ? 14
                                                                    : MediaQuery.of(context).size.height >
                                                                            700
                                                                        ? 14
                                                                        : MediaQuery.of(context).size.height >
                                                                                650
                                                                            ? 12
                                                                            : MediaQuery.of(context).size.height > 500
                                                                                ? 12
                                                                                : MediaQuery.of(context).size.height > 400
                                                                                    ? 12
                                                                                    : 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                              // maxLines: (exam?.examName
                                                              //                 ?.split(' ')
                                                              //                 .length ??
                                                              //             0) >
                                                              //         8
                                                              //     ? 2
                                                              //     : 1,
                                                              // softWrap: true,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "${score.toString()}/${exam?.totalMarks ?? 0}",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 16
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 14
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 14
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 12
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 12
                                                                                : 12,
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                        ),
                                                        Card(
                                                          elevation: 3,
                                                          color: (scorePercentage !=
                                                                      null &&
                                                                  scorePercentage >=
                                                                      (exam?.passingPercent ??
                                                                          0))
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  188, 240, 139)
                                                              : Colors.red,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 96
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 80
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 92
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 92
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 89
                                                                                : 100,
                                                            height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height >
                                                                    800
                                                                ? 34
                                                                : MediaQuery.of(context)
                                                                            .size
                                                                            .height >
                                                                        700
                                                                    ? 28
                                                                    : MediaQuery.of(context).size.height >
                                                                            650
                                                                        ? 30
                                                                        : MediaQuery.of(context).size.height >
                                                                                500
                                                                            ? 30
                                                                            : MediaQuery.of(context).size.height > 400
                                                                                ? 30
                                                                                : 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .transparent,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.1),
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                  blurRadius: 4,
                                                                  spreadRadius:
                                                                      1,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${scorePercentage ?? ''}%',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height >
                                                                          800
                                                                      ? 16
                                                                      : MediaQuery.of(context).size.height >
                                                                              700
                                                                          ? 14
                                                                          : MediaQuery.of(context).size.height > 650
                                                                              ? 14
                                                                              : MediaQuery.of(context).size.height > 500
                                                                                  ? 12
                                                                                  : MediaQuery.of(context).size.height > 400
                                                                                      ? 12
                                                                                      : 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            bottomNavigationBar:
                bottomBarVisibility ? CustomBottomNavBar() : null,
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/score_history/model/screen/view_model/score_history_view_model.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
// import 'package:indrayani/utils/common_widgets/user_drawer.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/internet_connectivity.dart';
// import 'package:indrayani/utils/loader.dart';

// class ScoreHistoryScreen extends StatefulWidget {
//   ScoreHistoryScreen({Key? key}) : super(key: key);

//   @override
//   _ScoreHistoryScreenState createState() => _ScoreHistoryScreenState();
// }

// class _ScoreHistoryScreenState extends State<ScoreHistoryScreen> {
//   ScoreHistoryViewModel scoreHistoryViewModel = Get.put(ScoreHistoryViewModel());
//   List<Map<String, dynamic>> trendingExams = [];
//   bool hasSearched = false;
//   List<Map<String, dynamic>> filteredExams = [];
//   List<bool> expandedItems = [];
//   List<bool> checkedItems = [];
//   final TextEditingController _searchController = TextEditingController();
//   bool isApiFetched = false;
//   List<Map<String, dynamic>> selectedExams = [];

//   @override
//   void initState() {
//     super.initState();
//     showLoadingDialog();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       //await fetchData();
//     });
//     checkConnectivity();
//   }

//   // Future<void> fetchData() async {
//   //   await scoreHistoryViewModel.fetchScoreHistory();
//   //   setState(() {
//   //     trendingExams = scoreHistoryViewModel.scoreHistoryList; // Assuming scoreHistoryList is the list of exams
//   //     isApiFetched = true; // Mark API data as fetched
//   //     filteredExams = List.from(trendingExams); // Initialize filtered exams
//   //   });
//   // }

//   void filterExams(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredExams = List.from(trendingExams); // Reset to all exams
//         hasSearched = false; // Reset search flag
//       } else {
//         filteredExams = trendingExams
//             .where((exam) =>
//                 exam['examName'].toLowerCase().contains(query.toLowerCase()))
//             .toList();
//         hasSearched = true; // Set flag to true when search is performed
//       }
//       // Initialize expanded and checked items based on filtered exams length
//       expandedItems = List<bool>.filled(filteredExams.length, false);
//       checkedItems = List<bool>.filled(filteredExams.length, false);
//     });
//   }

//   void clearSearch() {
//     _searchController.clear();
//     filterExams('');
//   }

//   void applySelection() {
//     // Collect selected exams
//     selectedExams.clear();
//     for (int i = 0; i < filteredExams.length; i++) {
//       if (checkedItems[i]) {
//         selectedExams.add(filteredExams[i]);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: bodyBGColor,
//         appBar: const CustomAppBar(
//           containerText: "Score History",
//           imagePath: "assets/Score_History/icon.png",
//         ),
//         drawer: const UserDrawer(),
//         body: Stack(
//           children: [
//             CustomPaint(
//               painter: HeaderCurvedContainer(),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 50.0, top: 18.0),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "Exam Attempt List",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 60.0, left: 15, right: 15),
//               child: Card(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 30.0, left: 17, right: 17),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.80,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                               width: 1,
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: TextFormField(
//                                   controller: _searchController,
//                                   onChanged: (value) {
//                                     filterExams(value);
//                                   },
//                                   decoration: const InputDecoration(
//                                     hintText: "All",
//                                     border: InputBorder.none,
//                                     contentPadding:
//                                         EdgeInsets.only(left: 10, top: 9),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 color: const Color.fromARGB(255, 10, 34, 100),
//                                 child: IconButton(
//                                   icon: const Icon(Icons.search),
//                                   color: Colors.white,
//                                   onPressed: () {},
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 5.0, left: 17, right: 17),
//                         child: Container(
//                           color: Colors.grey[300],
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Exam',
//                                   style: TextStyle(
//                                       color: Colors.grey[600],
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 14),
//                                 ),
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                                 Text(
//                                   'User Score',
//                                   style: TextStyle(
//                                       color: Colors.grey[600],
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 14),
//                                 ),
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                                 Text(
//                                   'Date & Time',
//                                   style: TextStyle(
//                                       color: Colors.grey[600],
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: filteredExams.length,
//                           itemBuilder: (context, index) {
//                             final exam = filteredExams[index];
//                             final int score = 80;
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
//                               child: Container(
//                                 height: MediaQuery.of(context).size.width * 0.2, // Set desired height here
//                                 decoration: BoxDecoration(
//                                   color: score > 35
//                                       ? Color.fromARGB(255, 221, 255, 222)
//                                       : const Color.fromARGB(255, 255, 207, 203), // Conditional background color
//                                 ),
//                                 child: ListTile(
//                                   contentPadding: EdgeInsets.only(left: 5), // Remove internal padding
//                                   title: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         exam['examCode'] ?? '',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                       SizedBox(height: 10,),
//                                       Text(
//                                         exam['examName'] ?? '',
//                                         style: const TextStyle(fontSize: 14, color: Colors.black54),
//                                       ),
//                                     ],
//                                   ),
//                                   trailing: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           score.toString(),
//                                           style: const TextStyle(fontSize: 14, color: Colors.black87),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 70,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(exam['examDate'] ?? '2024-09-23 14:00',
//                                             style: TextStyle(fontSize: 12, color: Colors.black54),
//                                           ),
//                                           Card(
//                                             elevation: 3,
//                                             color: Color.fromARGB(255, 188, 240, 139),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                             child: Container(
//                                               width: MediaQuery.of(context).size.width * 0.22,
//                                               height: MediaQuery.of(context).size.height * 0.033,
//                                               alignment: Alignment.center,
//                                               child: Text(
//                                                 'Analysis',
//                                                 style: TextStyle(fontSize: 14),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
