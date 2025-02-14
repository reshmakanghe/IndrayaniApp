import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/auth_module/login/model/login_data_model.dart';
import 'package:indrayani/module/auth_module/login/screens/otp_screen.dart';
import 'package:indrayani/module/auth_module/login/view_model/login_view_model.dart';
import 'package:indrayani/module/auth_module/signup/screen/signup_screen.dart';
import 'package:indrayani/module/home/screens/home_screen.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/bottom_bar_widget/screen/bottom_bar_widget.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/constants/StringConstants/string_constants.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  static const focusedBorderColor = Colors.cyanAccent;
  static Color fillColor = Colors.grey.withOpacity(0.5);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final LoginViewModel loginDataViewModel = Get.put(LoginViewModel());

  final TextEditingController pinController = TextEditingController();

  // final TextEditingController loginMobileNumberController =
  //     TextEditingController();

  bool isContainerVisible = false;
  bool isSumbitting = false;

  final FocusNode focusNode = FocusNode();

  final defaultPinTheme = PinTheme(
    width: MediaQuery.of(Get.context!).size.width * 0.2,
    height: MediaQuery.of(Get.context!).size.height * 0.07,
    textStyle: TextStyle(
      fontSize: 22,
      color: Colors.grey.withOpacity(0.3),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: Colors.grey.withOpacity(0.3),
    ),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // pingersListViewModel.getPingersList();
    });
    super.initState();
    loginDataViewModel.loginMobileNumberController.text = "";
    loginDataViewModel.passwordController.text = "";
    checkConnectivity();
  }

  // @override
  // void dispose() {
  //   // Clear the controller when the login page is disposed
  //   loginDataViewModel.loginMobileNumberController.clear();
  //   loginDataViewModel.loginMobileNumberController.dispose();
  //   super.dispose();
  // }

  @override
  @override
  Widget build(BuildContext context) {
    return InternetAwareWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            final isMedium = constraints.maxWidth > 400;

            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Login/BG1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.0),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: isWide ? 5 : (isMedium ? 10 : 25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: isWide ? 140 : (isMedium ? 120 : 80),
                            height: isWide ? 140 : (isMedium ? 120 : 80),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage("assets/images/Logo/logo.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(width: isWide ? 1 : (isMedium ? 3 : 4)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome to",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 1, 37, 58),
                                  fontWeight: FontWeight.w300,
                                  fontSize: isWide ? 32 : (isMedium ? 30 : 20),
                                  height: 1,
                                ),
                              ),
                              Text(
                                "INDRAYANI",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 1, 37, 58),
                                  fontSize: isWide ? 42 : (isMedium ? 35 : 32),
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height > 800
                            ? 50
                            : MediaQuery.of(context).size.height > 700
                                ? 50
                                : MediaQuery.of(context).size.height > 650
                                    ? 50
                                    : MediaQuery.of(context).size.height > 500
                                        ? 20
                                        : MediaQuery.of(context).size.height >
                                                400
                                            ? 38
                                            : 36),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "MOBILE NO. *",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height >
                                        800
                                    ? 13
                                    : MediaQuery.of(context).size.height > 700
                                        ? 12
                                        : MediaQuery.of(context).size.height >
                                                650
                                            ? 12
                                            : MediaQuery.of(context)
                                                        .size
                                                        .height >
                                                    500
                                                ? 11
                                                : MediaQuery.of(context)
                                                            .size
                                                            .height >
                                                        400
                                                    ? 10
                                                    : 10,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            TextFormField(
                              cursorColor: Colors.orange,
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              controller: loginDataViewModel
                                  .loginMobileNumberController,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                              255, 189, 179, 179)
                                          .withOpacity(0.4)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                              255, 189, 179, 179)
                                          .withOpacity(0.5)),
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.1),
                                labelStyle: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height >
                                          800
                                      ? 11
                                      : MediaQuery.of(context).size.height > 700
                                          ? 10
                                          : MediaQuery.of(context).size.height >
                                                  650
                                              ? 10
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      500
                                                  ? 8
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .height >
                                                          400
                                                      ? 8
                                                      : 7,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                errorMaxLines: 1,
                                hintText: 'Enter Mobile Number',
                                hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: isWide ? 14 : (isMedium ? 12 : 10),
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 9.0, horizontal: 20.0),
                              ),
                              validator: (value) {
                                RegExp regex = RegExp(r'^\d{10}$');
                                if (value == null || value.isEmpty) {
                                  return 'Mobile number is required';
                                } else if (value.length < 1) {
                                  return null;
                                } else if (!regex.hasMatch(value)) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height > 800
                            ? 30
                            : MediaQuery.of(context).size.height > 700
                                ? 30
                                : MediaQuery.of(context).size.height > 650
                                    ? 30
                                    : MediaQuery.of(context).size.height > 500
                                        ? 26
                                        : MediaQuery.of(context).size.height >
                                                400
                                            ? 24
                                            : 23),
                    Obx(() => AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: SizedBox(
                              width: constraints.maxWidth,
                              key: UniqueKey(),
                              child: ElevatedButton(
                                onPressed: () async {
                                  String mobileNumber = loginDataViewModel
                                      .loginMobileNumberController.text;
                                  RegExp regex = RegExp(r'^[789]\d{8,9}$');
                                  if (!regex.hasMatch(mobileNumber)) {
                                    Get.snackbar(
                                      backgroundColor: Colors.black,
                                      colorText: Colors.white,
                                      'Error',
                                      'Please enter a valid mobile number',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                    return;
                                  } else {
                                    final signCode =
                                        await SmsAutoFill().getAppSignature;
                                    print(
                                        "App Signature--------------->$signCode");
                                    loginDataViewModel.toggleVisibility;
                                    showLoadingDialog();
                                    APIBaseModel<LoginDataModel?>?
                                        responseData =
                                        await loginDataViewModel.getOtpForLogin(
                                            mobileNumber: mobileNumber);

                                    hideLoadingDialog();
                                    if (responseData?.status == true) {
                                      Get.snackbar(
                                        backgroundColor: Colors.black,
                                        colorText: Colors.white,
                                        '',
                                        responseData?.message ??
                                            "OTP sent on email",
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                      return Get.offAll(OtpScreen(
                                        mobileNumberController: mobileNumber,
                                      ));
                                    } else {
                                      Get.snackbar(
                                        backgroundColor: Colors.black,
                                        colorText: Colors.white,
                                        'Error',
                                        responseData?.message ??
                                            "Something went wrong",
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                      return;
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                  splashFactory: InkRipple.splashFactory,
                                  overlayColor:
                                      MaterialStateProperty.resolveWith(
                                    (states) {
                                      return states
                                              .contains(MaterialState.pressed)
                                          ? Colors.grey
                                          : null;
                                    },
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    loginDataViewModel.isOTPVisible.value
                                        ? primaryColor
                                        : primaryColor,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'SEND OTP',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height > 800
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
                                                    ? 15
                                                    : MediaQuery.of(context)
                                                                .size
                                                                .height >
                                                            500
                                                        ? 13
                                                        : MediaQuery.of(context)
                                                                    .size
                                                                    .height >
                                                                400
                                                            ? 13
                                                            : 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 10.0),
                    const Text(
                      "OR",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10.0),
                    Obx(() => AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: SizedBox(
                              width: constraints.maxWidth,
                              key: UniqueKey(),
                              child: ElevatedButton(
                                onPressed: () async {
                                  ///TODO:Integration pending
                                  loginDataViewModel.toggleVisibility;
                                  //  showLoadingDialog();
                                  User? signInResult =
                                      await LoginViewModel.signInWithGoogle(
                                          context: context);
                                  //hideLoadingDialog();
                                  print("SIGNIN RESULT $signInResult");
                                  //if (signInResult?.emailVerified == true) {
                                  APIBaseModel<LoginDataModel?>? loginModel =
                                      await loginDataViewModel.login(
                                          email: signInResult?.email ?? "",
                                          gID: signInResult?.uid ?? "");
                                  // return Get.offAll(SignUp(
                                  //   gID: signInResult?.uid ?? "",
                                  //   isGoogleSignIn: true,
                                  //   emailId: signInResult?.email ?? "",
                                  // ));
                                  if (loginModel?.status == true) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder:
                                                (context) => //BottomNavigationBarWidget(bodyWidget:
                                                    HomeScreen()
                                            // )
                                            ));
                                  } else {
                                    Get.snackbar(
                                      backgroundColor: Colors.black,
                                      colorText: Colors.white,
                                      '',
                                      loginModel?.message ?? "Sign-in failed",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                    return Get.offAll(SignUp(
                                      gID: signInResult?.uid ?? "",
                                      isGoogleSignIn:
                                          // (signInResult?.uid ?? "").isNotEmpty
                                          // ?
                                          true,
                                      // : false,
                                      emailId: signInResult?.email ?? "",
                                    ));
                                  }
                                  // } else {
                                  //   String email = signInResult?.email ?? "";
                                  //   print("Google login email - $email");

                                  //   Get.snackbar(
                                  //     backgroundColor: Colors.black,
                                  //     colorText: Colors.white,
                                  //     'Error',
                                  //     // responseData?.message ??
                                  //     "Sign-in failed",
                                  //     snackPosition: SnackPosition.BOTTOM,
                                  //   );
                                  //   return Get.offAll(SignUp(
                                  //     gID: signInResult?.uid ?? "",
                                  //     isGoogleSignIn:
                                  //         (signInResult?.uid ?? "").isNotEmpty
                                  //             ? true
                                  //             : false,
                                  //     emailId: email,
                                  //   ));

                                  //   // Handle the case where signInWithGoogle did not return true
                                  //   // For example, you could show an error message or log the failure
                                  //   //  print("Sign-in failed");
                                  // }
                                },
                                style: ButtonStyle(
                                  splashFactory: InkRipple.splashFactory,
                                  overlayColor:
                                      MaterialStateProperty.resolveWith(
                                    (states) {
                                      return states
                                              .contains(MaterialState.pressed)
                                          ? Colors.grey
                                          : null;
                                    },
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    loginDataViewModel.isGoogleVisible.value
                                        ? primaryColor
                                        : primaryColor,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'SIGNING WITH GOOGLE',
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
                                                      ? 13
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .height >
                                                              400
                                                          ? 13
                                                          : 12),
                                ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                        height: MediaQuery.of(context).size.height > 800
                            ? 20
                            : MediaQuery.of(context).size.height > 700
                                ? 18
                                : MediaQuery.of(context).size.height > 650
                                    ? 18
                                    : MediaQuery.of(context).size.height > 500
                                        ? 5
                                        : MediaQuery.of(context).size.height >
                                                400
                                            ? 10
                                            : 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "CREATE A NEW ACCOUNT! ",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height > 800
                                  ? 17
                                  : MediaQuery.of(context).size.height > 700
                                      ? 16
                                      : MediaQuery.of(context).size.height > 650
                                          ? 15
                                          : MediaQuery.of(context).size.height >
                                                  500
                                              ? 10
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      400
                                                  ? 13
                                                  : 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUp(
                                      emailId: loginDataViewModel
                                              .emailController.text ??
                                          "",
                                      isGoogleSignIn: false,
                                    )));
                            loginDataViewModel.loginMobileNumberController
                                .clear();
                            loginDataViewModel.passwordController.clear();
                          },
                          child: Text(
                            "SIGNUP",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: MediaQuery.of(context).size.height > 800
                                  ? 17
                                  : MediaQuery.of(context).size.height > 700
                                      ? 16
                                      : MediaQuery.of(context).size.height > 650
                                          ? 15
                                          : MediaQuery.of(context).size.height >
                                                  500
                                              ? 10
                                              : MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      400
                                                  ? 10
                                                  : 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 3, 32, 107),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UpwardCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 20); // start at the bottom-left corner
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 20); // curve to the bottom-right corner
    path.lineTo(size.width, 0); // line to the top-right corner
    path.close(); // close the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true; // always re-clip
  }
}
