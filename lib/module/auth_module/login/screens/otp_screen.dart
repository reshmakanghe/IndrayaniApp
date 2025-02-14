import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/auth_module/login/model/login_data_model.dart';
import 'package:indrayani/module/auth_module/login/screens/login_screen.dart';
import 'package:indrayani/module/auth_module/login/view_model/login_view_model.dart';
import 'package:indrayani/module/home/screens/home_screen.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/bottom_bar_widget/screen/bottom_bar_widget.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatefulWidget {
  final String? mobileNumberController;
  OtpScreen({super.key, this.mobileNumberController});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final LoginViewModel loginDataViewModel = Get.put(LoginViewModel());
  Timer? _timer;
  bool _timerStarted = false;
  bool isMobileOtpVerified = false;
  final RxInt _remainingTime = 120.obs;

  @override
  void initState() {
    super.initState();
    _startTimerOnce();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimerOnce() {
    if (!_timerStarted) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (!mounted) return; // Check if the widget is still mounted
        if (_remainingTime.value > 0) {
          setState(() {
            _remainingTime.value--;
          });
        } else {
          _timer?.cancel();
          loginDataViewModel.passwordController.clear();
        }
      });
      _timerStarted = true;
    }
  }

  Future<bool> _onWillPop() async {
    // Navigate to the login screen when back button is pressed
    Get.offAll(LoginScreen());
    return Future.value(
        false); // Prevent default behavior of popping the screen
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Login/BG.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                spaceWidget(height: 60.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width > 600 ? 45 : 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width:
                            MediaQuery.of(context).size.width > 600 ? 140 : 90,
                        height:
                            MediaQuery.of(context).size.width > 600 ? 140 : 90,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Logo/logo.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome to",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 37, 58),
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                          ? 32
                                          : 20)),
                          Text("INDRAYANI",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 37, 58),
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                          ? 42
                                          : 32,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceWidget(height: 70.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: ConstantText(
                          text: "OTP",
                          fontSize: 12.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      spaceWidget(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: SizedBox(
                          height: 70,
                          child: PinFieldAutoFill(
                            currentCode:
                                loginDataViewModel.passwordController.text,
                            codeLength: 4,
                            controller: loginDataViewModel.passwordController,
                            decoration: BoxLooseDecoration(
                              gapSpace: 15.0,
                              strokeWidth: 1.0,
                              strokeColorBuilder:
                                  const FixedColorBuilder(Colors.transparent),
                              bgColorBuilder: FixedColorBuilder(
                                  Colors.grey.withOpacity(0.2)),
                              radius: const Radius.circular(10.0),
                            ),
                            onCodeChanged: (value) {
                              loginDataViewModel.passwordController.text =
                                  value!;
                            },
                          ),
                        ),
                      ),
                      spaceWidget(height: 10.0),
                      Obx(() => Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.timer,
                                    size: 20.0,
                                    color: Colors.black.withOpacity(0.5)),
                                SizedBox(width: 4),
                                Text(
                                  "${(_remainingTime.value ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime.value % 60).toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                      spaceWidget(height: 20.0),
                      Obx(() => Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_remainingTime.value == 0) {
                                    if (!isMobileOtpVerified) {
                                      APIBaseModel? otpResponse =
                                          await loginDataViewModel
                                              .getOtpForLogin(
                                                  mobileNumber: widget
                                                      .mobileNumberController);
                                      if (otpResponse?.status == true) {
                                        Get.snackbar(
                                            'OTP',
                                            otpResponse?.message ??
                                                'Please enter a valid OTP',
                                            backgroundColor: Colors.black,
                                            colorText: Colors.white,
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                        _resetAndStartTimer();
                                      }
                                    }
                                  } else {
                                    String otp = loginDataViewModel
                                        .passwordController.text;
                                    if (otp.isEmpty) {
                                      Get.snackbar(
                                          'Error', 'Please enter a valid OTP',
                                          backgroundColor: Colors.black,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM);
                                      return;
                                    } else {
                                      APIBaseModel<LoginDataModel?>?
                                          loginModel =
                                          await loginDataViewModel.login(
                                              mobileNumberController: widget
                                                  .mobileNumberController!);
                                      await loginDataViewModel
                                          .storeLoginResponseInSharedPreferences();
                                      if (loginModel?.status == true) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                //BottomNavigationBarWidget(
                                                // bodyWidget:
                                                HomeScreen(),
                                            //),
                                          ),
                                        );
                                      } else {
                                        Get.snackbar(
                                            'Error',
                                            loginModel?.message ??
                                                "Something went wrong",
                                            backgroundColor: Colors.black,
                                            colorText: Colors.white,
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      }
                                    }
                                  }
                                },
                                child: Text(
                                  _remainingTime.value == 0
                                      ? 'RESEND OTP'
                                      : 'LOGIN',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height >
                                              800
                                          ? 17
                                          : MediaQuery.of(context).size.height >
                                                  700
                                              ? 16
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      650
                                                  ? 15
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          500
                                                      ? 10
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              400
                                                          ? 13
                                                          : 12),
                                ),
                                style: ButtonStyle(
                                  splashFactory: InkRipple.splashFactory,
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetAndStartTimer() {
    _timer?.cancel();
    _remainingTime.value = 120;
    loginDataViewModel.passwordController.clear();
    _timerStarted = false;
    _startTimerOnce();
  }
}
