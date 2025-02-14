import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/category_module/view_model/category_view_model.dart';
import 'package:indrayani/module/home/screens/exam_details.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/custom_bottom_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';

class CategoryScreen2 extends StatefulWidget {
  @override
  State<CategoryScreen2> createState() => _CategoryScreen2State();
}

class _CategoryScreen2State extends State<CategoryScreen2> {
  final CategoryViewModel categoryViewModel = Get.put(CategoryViewModel());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showLoadingDialog();
      await categoryViewModel.fetchCategoryExams();
      hideLoadingDialog();

      // homeDataViewModel.trendingExamModels = trendingExams.map((exam) {
      //   return TrendigUpcomingExamDataModel.fromJson(exam);
      // }).toList();
    });

    super.initState();
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final bottomBarVisibility =
            Get.find<NavigationController>().showBottomBar.value;
        return SafeArea(
          child: Scaffold(
            backgroundColor: bodyBGColor,
            appBar: const CustomAppBar(
              containerText: "EXAM CATEGORY",
              imagePath: "assets/Icon/about_exam_icon.png",
            ),
            drawer: UserDrawer(),
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
                Column(
                  children: [
                    // Use LayoutBuilder to adapt search bar size
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double searchBarWidth = constraints.maxWidth * 0.82;
                        double searchBarHeight = 50.0; // Fixed height

                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            height: searchBarHeight,
                            width: searchBarWidth,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1),
                            ),
                            child: TextFormField(
                              onChanged: (value) {
                                categoryViewModel.searchCategories(value);
                              },
                              decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(left: 10, top: 9),
                                suffixIcon: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 13, 38, 104),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.search),
                                    color: Colors.white,
                                    onPressed: () {
                                      categoryViewModel.clearSearch();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Obx(() {
                        if (categoryViewModel.isLoading.value) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: primaryColor),
                          );
                        }
                        var categories = categoryViewModel
                                .filteredCategoryExamModels
                                .value
                                ?.first
                                .categories ??
                            [];
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 60, left: 20, right: 20.0),
                          child: Card(
                            elevation: 4,
                            child: ListView.builder(
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                var category = categories[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Container(
                                        color: primaryColor,
                                        child: ExpansionTile(
                                          dense: true,
                                          title: Text(
                                            category.categoryName ?? '',
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          tilePadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                          backgroundColor: primaryColor,
                                          collapsedBackgroundColor:
                                              primaryColor,
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide
                                                .none, // Removes the border color
                                          ),
                                          children:
                                              category.subcats!.map((subcat) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 8.0,
                                                  child: Container(
                                                      color: Colors.white),
                                                ),
                                                Container(
                                                  color: Colors.yellow[100],
                                                  child: ExpansionTile(
                                                    dense: true,
                                                    title: Text(
                                                      subcat.categoryName ?? '',
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    leading: const Icon(
                                                        Icons.add,
                                                        color: Colors.black),
                                                    tilePadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16.0),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 255, 217, 186),
                                                    collapsedBackgroundColor:
                                                        const Color.fromARGB(
                                                            255, 255, 217, 186),
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      side: BorderSide
                                                          .none, // Removes the border color
                                                    ),
                                                    children: subcat.exams!
                                                        .map((exam) {
                                                      return Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 8.0,
                                                            child: Container(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Container(
                                                            color: Colors
                                                                .yellow[100],
                                                            child: ListTile(
                                                              dense: true,
                                                              title: Text(
                                                                exam.examName ??
                                                                    '',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              tileColor:
                                                                  Colors.white,
                                                              onTap: () {
                                                                if (exam.examCode !=
                                                                    null) {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ExamDetailsPage(
                                                                        examCode:
                                                                            exam.examCode!,
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            241,
                                                                            183,
                                                                            183),
                                                                        isPurchase:
                                                                            exam.isPurchase,
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  // Handle the case where examCode is null
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar:
                bottomBarVisibility ? CustomBottomNavBar() : null,
          ),
        );
      },
    );
  }
}
