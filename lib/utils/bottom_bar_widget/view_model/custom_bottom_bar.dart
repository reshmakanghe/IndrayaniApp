import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/Cart/screen/cart_screen.dart';
import 'package:indrayani/module/home/screens/home_screen.dart';
import 'package:indrayani/module/info_video_module/screen/info_video_screen.dart';
import 'package:indrayani/module/user_profile/screen/user_profile.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Separate Obx for bottom navigation bar
      final index =
          IndrayaniAppGLobal.instance.bottomNavigationBarSelectedIndex.value;
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.width > 600
              ? 70
              : MediaQuery.of(context).size.width > 400
                  ? 60
                  : 60, // Adjust height based on screen width
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildBottomNavigationItem(
                    0, 'Home', Icons.home, Icons.home_outlined, index),
                _buildBottomNavigationItem(1, 'Video', Icons.video_library,
                    Icons.video_library_outlined, index),
                _buildBottomNavigationItem(2, 'Cart', Icons.shopping_cart,
                    Icons.shopping_cart_outlined, index),
                _buildBottomNavigationItem(
                    3, 'Profile', Icons.person, Icons.person_outline, index),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBottomNavigationItem(int index, String label, IconData icon,
      IconData outlineIcon, int selectedIndex) {
    return IconButton(
      icon: Icon(
        selectedIndex == index ? icon : outlineIcon,
        color: selectedIndex == index ? primaryColor : Colors.grey,
        size: 30,
      ),
      onPressed: () {
        IndrayaniAppGLobal.instance.bottomNavigationBarSelectedIndex.value =
            index;

        // Handle navigation based on the index
        switch (index) {
          case 0:
            // Navigate to Home
            Get.off(
                HomeScreen()); // Adjust the route name according to your app's routing
            break;
          case 1:
            // Navigate to Video Library
            Get.off(
                InfoVideoScreen()); // Adjust the route name according to your app's routing
            break;
          case 2:
            // Navigate to Cart
            Get.off(
                CartScreen()); // Adjust the route name according to your app's routing
            break;
          case 3:
            // Navigate to Profile
            Get.off(
                ProfileScreen()); // Adjust the route name according to your app's routing
            break;
          default:
            Get.toNamed('/home'); // Default route, if needed
        }
      },
    );
  }
}
