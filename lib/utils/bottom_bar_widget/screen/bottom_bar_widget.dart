// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/Cart/screen/cart_screen.dart';
// import 'package:indrayani/module/home/screens/home_screen.dart';
// import 'package:indrayani/module/info_video_module/screen/info_video_screen.dart';
// import 'package:indrayani/module/payment_module/screen/payment_screen.dart';
// import 'package:indrayani/module/score_module/screen/score_card_screen.dart';
// import 'package:indrayani/module/subscription_module/screen/subscription_screen.dart';
// import 'package:indrayani/module/user_profile/screen/user_profile.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/constants/asset_constant/asset_constant.dart';
// import 'package:indrayani/utils/initialization_services/singleton_service.dart';

// class BottomNavigationBarWidget extends StatefulWidget {
//   final AppBar? appBarWidget;
//   final Widget bodyWidget;

//   BottomNavigationBarWidget({
//     Key? key,
//     this.appBarWidget,
//     required this.bodyWidget,
//   }) : super(key: key);

//   @override
//   State<BottomNavigationBarWidget> createState() =>
//       _BottomNavigationBarWidgetState();
// }

// class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
//   late List<Widget> bottomBarScreens;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the bottomBarScreens list here
//     bottomBarScreens = [
//       HomeScreen(),
//       const InfoVideoScreen(),
//       CartScreen(),
//       ProfileScreen(),
//       // ScoreCardScreen(examId: "1"),
//       SubscriptionScreen(),
//       PaymentSuccessScreen()

//       // Add other screens here
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: widget.appBarWidget,
//       extendBody: true,
//       resizeToAvoidBottomInset: true,
//       body: Obx(() {
//         // Get the current index from the observable variable
//         final index =
//             IndrayaniAppGLobal.instance.bottomNavigationBarSelectedIndex.value;
//         return bottomBarScreens[index];
//       }),
//       bottomNavigationBar: Obx(() {
//         // Separate Obx for bottom navigation bar
//         final index =
//             IndrayaniAppGLobal.instance.bottomNavigationBarSelectedIndex.value;
//         return Container(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
//           child: BottomAppBar(
//             shape: const CircularNotchedRectangle(),
//             notchMargin: 8.0,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             height: MediaQuery.of(context).size.width > 600
//                 ? 70
//                 : MediaQuery.of(context).size.width > 400
//                     ? 60
//                     : 60, // Reduced height
//             color: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   _buildBottomNavigationItem(
//                       0, 'Home', Icons.home, Icons.home_outlined, index),
//                   _buildBottomNavigationItem(1, 'Video', Icons.video_library,
//                       Icons.video_library_outlined, index),
//                   _buildBottomNavigationItem(2, 'Cart', Icons.shopping_cart,
//                       Icons.shopping_cart_outlined, index),
//                   _buildBottomNavigationItem(
//                       3, 'Profile', Icons.person, Icons.person_outline, index),
//                   // _buildBottomNavigationItem(
//                   //     4, 'Score', Icons.score, Icons.score_outlined, index),
//                   // _buildBottomNavigationItem(3, 'Subscription',
//                   //     Icons.subscriptions, Icons.subscriptions_outlined, index),
//                   // _buildBottomNavigationItem(5, 'Payment', Icons.payment,
//                   //     Icons.payment_outlined, index),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildBottomNavigationItem(int itemIndex, String label,
//       IconData selectedIcon, IconData unselectedIcon, int selectedIndex) {
//     return GestureDetector(
//       onTap: () {
//         IndrayaniAppGLobal.instance.bottomNavigationBarSelectedIndex.value =
//             itemIndex;
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             selectedIndex == itemIndex ? selectedIcon : unselectedIcon,
//             size: 28.0, // Reduced icon size
//             color: selectedIndex == itemIndex ? primaryColor : Colors.grey,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 10.0,
//               color: selectedIndex == itemIndex ? primaryColor : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//code with above logic using persistent bottom bar

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/payment_history/screen/payment_history.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:indrayani/module/Cart/screen/cart_screen.dart';
// import 'package:indrayani/module/home/screens/home_screen.dart';
// import 'package:indrayani/module/info_video_module/screen/info_video_screen.dart';
// import 'package:indrayani/module/payment_module/screen/payment_screen.dart';
// import 'package:indrayani/module/subscription_module/screen/subscription_screen.dart';
// import 'package:indrayani/module/user_profile/screen/user_profile.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/initialization_services/singleton_service.dart';

// class BottomNavigationBarWidget extends StatefulWidget {
//   final AppBar? appBarWidget;
//   final Widget bodyWidget;

//   BottomNavigationBarWidget({
//     Key? key,
//     this.appBarWidget,
//     required this.bodyWidget,
//   }) : super(key: key);

//   @override
//   State<BottomNavigationBarWidget> createState() =>
//       _BottomNavigationBarWidgetState();
// }

// class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
//   late PersistentTabController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController(
//         initialIndex:
//             IndrayaniAppGLobal.instance.bottomNavigationBarSelectedIndex.value);
//   }

//   List<Widget> _buildScreens() {
//     return [
//       HomeScreen(),
//       const InfoVideoScreen(),
//       CartScreen(),
//       ProfileScreen(),
//       // SubscriptionScreen(),
//       // PaymentHistoryScreen(),
//     ];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: "Home",
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.video_library),
//         title: "Video",
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.shopping_cart),
//         title: "Cart",
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.person),
//         title: "Profile",
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       // PersistentBottomNavBarItem(
//       //   icon: Icon(Icons.subscriptions),
//       //   title: "Subscription",
//       //   activeColorPrimary: primaryColor,
//       //   inactiveColorPrimary: Colors.grey,
//       // ),
//       // PersistentBottomNavBarItem(
//       //   icon: Icon(Icons.payment),
//       //   title: "Payment",
//       //   activeColorPrimary: primaryColor,
//       //   inactiveColorPrimary: Colors.grey,
//       // ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: widget.appBarWidget,
//       extendBody: true,
//       resizeToAvoidBottomInset: true,
//       body: PersistentTabView(
//         isVisible: true,
//         context,
//         controller: _controller,
//         screens: _buildScreens(),
//         items: _navBarsItems(),
//         backgroundColor: Colors.white,
//         handleAndroidBackButtonPress: true,
//         resizeToAvoidBottomInset: true,
//         stateManagement: true,
//         decoration: NavBarDecoration(
//           borderRadius: BorderRadius.circular(30.0),
//           colorBehindNavBar: Colors.white,
//         ),
//         navBarStyle: NavBarStyle.style12, // Ensure this style supports 6 items
//       ),
//     );
//   }
// }








// code with skip bottom bar on 
//exam screen 
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/Cart/screen/cart_screen.dart';
// import 'package:indrayani/module/exam_questions_module/exam_questions_screen/exam_questions_screen.dart';
// import 'package:indrayani/module/exam_questions_module/exam_questions_view_model/exam_questions_view_model.dart';
// import 'package:indrayani/module/home/screens/home_screen.dart';
// import 'package:indrayani/module/info_video_module/screen/info_video_screen.dart';
// import 'package:indrayani/module/payment_history/screen/payment_history.dart';

// import 'package:indrayani/module/user_profile/screen/user_profile.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/initialization_services/singleton_service.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// class BottomNavigationBarWidget extends StatefulWidget {
//   final AppBar? appBarWidget;
//   final Widget bodyWidget;
//   final String? examCode;

//   BottomNavigationBarWidget({
//     Key? key,
//     this.appBarWidget,
//     required this.bodyWidget,
//     this.examCode,
//   }) : super(key: key);

//   @override
//   State<BottomNavigationBarWidget> createState() =>
//       _BottomNavigationBarWidgetState();
// }

// class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
//   late PersistentTabController _controller;
//   ExamQuestionsViewModel examQuestionsViewModel =
//       Get.put(ExamQuestionsViewModel());

//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController(
//       initialIndex:
//           IndrayaniAppGLobal.instance.bottomNavigationBarSelectedIndex.value,
//     );
//   }

//   List<Widget> _buildScreens() {
//     return [
//       HomeScreen(),
//       const InfoVideoScreen(),
//       CartScreen(),
//       ProfileScreen(),
//       // PaymentHistoryScreen(),
//       // Add more screens as needed
//     ];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: ("Home"),
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.video_library),
//         title: ("Video"),
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.shopping_cart),
//         title: ("Cart"),
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.person),
//         title: ("Profile"),
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screens = _buildScreens();
//     final items = _navBarsItems();

//     return Scaffold(
//       appBar: widget.appBarWidget,
//       body: Stack(
//         children: [
//           Obx(() {
//             if (examQuestionsViewModel.isExamScreen.value) {
//               // If on ExamScreen, display it directly
//               return ExamScreen(
//                 examCode: examQuestionsViewModel.examCode.value,
//               ); // Replace with your exam screen logic
//             } else {
//               // Otherwise, show PersistentTabView
//               return PersistentTabView(
//                 context,
//                 controller: _controller,
//                 screens: screens,
//                 items: items,
//                 confineToSafeArea: true,
//                 backgroundColor: Colors.white,
//                 handleAndroidBackButtonPress: true,
//                 resizeToAvoidBottomInset: true,
//                 stateManagement: false,
//                 navBarHeight: MediaQuery.of(context).size.width > 600
//                     ? 70
//                     : MediaQuery.of(context).size.width > 400
//                         ? 60
//                         : 60,
//                 margin: const EdgeInsets.all(0.0),
//                 bottomScreenMargin: 0.0,
//                 onItemSelected: (index) {
//                   IndrayaniAppGLobal
//                       .instance.bottomNavigationBarSelectedIndex.value = index;
//                   setState(() {
//                     examQuestionsViewModel.isExamScreen.value =
//                         screens[index] is ExamScreen;
//                   });
//                 },
//                 selectedTabScreenContext: (context) {},
//                 decoration: NavBarDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   colorBehindNavBar: Colors.white,
//                 ),
//                 navBarStyle: NavBarStyle.style12,
//               );
//             }
//           }),
//         ],
//       ),
//     );
//   }
// }




//   // Widget build(BuildContext context) {
//   //   final screens = _buildScreens();
//   //   final items = _navBarsItems();

//   //   return Scaffold(
//   //     appBar: widget.appBarWidget,
//   //     body: isQuestionScreen
//   //         ? widget.bodyWidget
//   //         : PersistentTabView(
//   //             context,
//   //             controller: _controller,
//   //             screens: screens,
//   //             items: items,
//   //             confineToSafeArea: true,
//   //             backgroundColor: Colors.white,
//   //             handleAndroidBackButtonPress: true,
//   //             resizeToAvoidBottomInset: true,
//   //             stateManagement: false,
//   //             navBarHeight: MediaQuery.of(context).size.width > 600
//   //                 ? 70
//   //                 : MediaQuery.of(context).size.width > 400
//   //                     ? 60
//   //                     : 60,
//   //             margin: const EdgeInsets.all(0.0),
//   //             bottomScreenMargin: 0.0,
//   //             onItemSelected: (index) {
//   //               IndrayaniAppGLobal
//   //                   .instance.bottomNavigationBarSelectedIndex.value = index;
//   //               setState(() {
//   //                 isQuestionScreen = screens[index] is ExamScreen;
//   //               });
//   //             },
//   //             selectedTabScreenContext: (context) {},
//   //             decoration: NavBarDecoration(
//   //               borderRadius: BorderRadius.circular(10.0),
//   //               colorBehindNavBar: Colors.white,
//   //             ),
//   //             navBarStyle: NavBarStyle.style12,
//   //           ),
//   //   );
//   // }
// //}
