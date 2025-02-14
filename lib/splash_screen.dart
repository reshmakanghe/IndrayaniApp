import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/auth_module/login/screens/login_screen.dart';
import 'package:indrayani/module/home/screens/home_screen.dart';
import 'package:indrayani/utils/bottom_bar_widget/screen/bottom_bar_widget.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  IndrayaniAppGLobal indrayaniAppGLobal = IndrayaniAppGLobal.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 3));

      SharedPreferences.getInstance().then((value) {
        indrayaniAppGLobal.preferences = value;
        indrayaniAppGLobal.loginViewModel.checkForLoginSessionExists();
        // indrayaniAppGLobal.signupViewModel.checkForLoginSessionExists();

        Get.offAll(
            indrayaniAppGLobal.loginViewModel.loginDataModel?.value == null
                ? LoginScreen()
                //: BottomNavigationBarWidget(bodyWidget:
                : HomeScreen()
            // )
            );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InternetAwareWidget(
      child: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/Logo/logo.gif",
              width: double.infinity,

              height: double.infinity,
              fit: BoxFit.cover, // You can adjust the fit property as needed
            ),
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/Splash_screen/For Android/XXHDPI/Portrait-960x1600.gif"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
        ],
      ),
    ));
  }
}
