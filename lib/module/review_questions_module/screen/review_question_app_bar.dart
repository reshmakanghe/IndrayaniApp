import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_view_model/exam_questions_view_model.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_header_container.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

class ReviewQuestionAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final String imagePath;
  final String containerText;
  final double? height;

  const ReviewQuestionAppBar({
    Key? key,
    this.title,
    required this.imagePath,
    required this.containerText,
    this.height,
  })  : preferredSize = const Size.fromHeight(200.0),
        super(key: key);

  @override
  _ReviewQuestionAppBarState createState() => _ReviewQuestionAppBarState();
}

class _ReviewQuestionAppBarState extends State<ReviewQuestionAppBar> {
  @override
  void initState() {
    super.initState();
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height,
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
                ConstantText(text: widget.title),
              ],
            ),
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  "assets/images/Logo/logo100x100.png",
                  height: 50.0,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomContainer(
                  imagePath: widget.imagePath,
                  text: widget.containerText,
                  containerHeight: 50.0,
                ),
              ),
              // Container(
              //   color: Colors.black,
              //   width: MediaQuery.of(context).size.width * 0.3,
              //   height: 50.0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const Icon(Icons.alarm, color: Colors.white),
              //       const SizedBox(width: 10.0),
              //       ConstantText(
              //         text: formatTime(
              //             examQuestionsViewModel.secondsElapsed.value),
              //         // formatTime(examQuestionsViewModel
              //         //         .timeSpentOnQuestions[
              //         //     examQuestionsViewModel.currentQuestionIndex.value]),
              //         color: Colors.white,
              //         fontSize: 18.0,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.05,
            // width: 300.0,
            color: primaryColor,
          )
        ],
      ),
    );
  }
}
