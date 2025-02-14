import 'package:flutter/material.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';

class Category_ExamList_Screen extends StatelessWidget {
  // String? selectedExams;
  const Category_ExamList_Screen(
      {super.key, required List<Map<String, dynamic>> selectedExams});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyBGColor,
      appBar: CustomAppBar(
        containerText: "Exam List Category",
        imagePath: "assets/images/Logo/logo100x100.png",
      ),
      drawer: UserDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CustomPaint(
              painter: HeaderCurvedContainer(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
