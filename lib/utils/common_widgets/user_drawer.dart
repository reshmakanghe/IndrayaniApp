import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/Cart/screen/cart_screen.dart';
import 'package:indrayani/module/category_module/screen/category_screen.dart';
import 'package:indrayani/module/category_module/screen/category_screen2.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_screen/exam_questions_screen.dart';
import 'package:indrayani/module/home/screens/home_screen.dart';
import 'package:indrayani/module/info_video_module/screen/info_video_screen.dart';
import 'package:indrayani/module/payment_history/screen/payment_history.dart';
import 'package:indrayani/module/payment_module/screen/thank_you_page.dart';
import 'package:indrayani/module/score_history/screen/score_history_screen.dart';
import 'package:indrayani/module/score_module/screen/score_card_screen.dart';
import 'package:indrayani/module/subscription_module/screen/subscription_screen.dart';
import 'package:indrayani/module/user_profile/view_model/user_data_view_model.dart';
import 'package:indrayani/utils/bottom_bar_widget/screen/bottom_bar_widget.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // showLoadingDialog();
      await userDataViewModel.getUsersDetails();
      //  hideLoadingDialog();
    });
  }

  UserDataViewModel userDataViewModel = Get.put(UserDataViewModel());
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: MediaQuery.of(context).size.width *
          0.65, // Decreased width to 75% of the screen width
      child: ClipRRect(
        child: Drawer(
          backgroundColor: bodyBGColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  curve: Curves.bounceIn,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                  ),
                  child: Obx(
                    () {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userDataViewModel.userListDataModel.value
                                    ?.responseBody?.first?.firstName ??
                                "",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          spaceWidget(height: 30.0),
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              spaceWidget(width: 10.0),
                              ConstantText(
                                text: userDataViewModel.userListDataModel.value
                                        ?.responseBody?.first?.email ??
                                    '',
                                fontSize: 14.0,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ],
                          ),
                          spaceWidget(height: 10.0),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_android_rounded,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              spaceWidget(width: 10.0),
                              ConstantText(
                                text: userDataViewModel.userListDataModel.value
                                        ?.responseBody?.first?.mobile ??
                                    '',
                                fontSize: 14.0,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  )),
              spaceWidget(height: 30.0),
              ListTile(
                leading: const Icon(Icons.home),
                title: const ConstantText(text: 'Home'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.category),
                title: const ConstantText(text: 'Category'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CategoryScreen2()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.score),
                title: const ConstantText(text: 'Score History'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ScoreHistoryScreen()),
                  );

                  // Handle profile navigation
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const ConstantText(text: 'My Cart'),
                onTap: () {
                  IndrayaniAppGLobal
                      .instance.bottomNavigationBarSelectedIndex.value = 2;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  ); // Update the bottom navigation bar index to navigate to CartScreen
                },
              ),
              ListTile(
                leading: const Icon(Icons.subscriptions),
                title: const ConstantText(text: 'Subscriptions'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          //  BottomNavigationBarWidget(
                          //   bodyWidget:
                          SubscriptionScreen(),
                    ),
                    // ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.payment_rounded),
                title: const ConstantText(text: 'Payment History'),
                onTap: () {
                  //Get.off(const PaymentHistoryScreen());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          //  BottomNavigationBarWidget(
                          //   bodyWidget:
                          PaymentHistoryScreen(),
                    ),
                    // ),
                  );
                  // Handle navigation to Payment screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_collection_rounded),
                title: const ConstantText(text: 'Info & Video'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => InfoVideoScreen(),
                    ),
                  );
                  // Handle navigation to Info & Video screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
