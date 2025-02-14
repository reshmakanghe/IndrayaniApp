import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:indrayani/module/auth_module/login/model/login_data_model.dart';
import 'package:indrayani/module/auth_module/login/screens/login_screen.dart';

import 'package:indrayani/module/auth_module/login/view_model/login_view_model.dart';
import 'package:indrayani/module/auth_module/signup/model/signup_data_model.dart';

import 'package:indrayani/module/auth_module/signup/view_model/signup_view_model.dart';
import 'package:indrayani/module/home/screens/home_screen.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/bottom_bar_widget/screen/bottom_bar_widget.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';

import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sms_autofill/sms_autofill.dart';

class SignUp extends StatefulWidget {
  String emailId;
  bool? isGoogleSignIn;
  String? gID;
  SignUp({super.key, required this.emailId, this.isGoogleSignIn, this.gID});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  LoginViewModel loginViewModel = Get.put(LoginViewModel());
  SignupViewModel signupViewModel = Get.put(SignupViewModel());

  String timezone = "";
  DateTime dateTime = DateTime.now();

  final RxInt _remainingTime = 120.obs; // 5 minutes timer
  Timer? _timer;
  final RxString mobile = "".obs;
  final RxString? email = "".obs;

  bool _timerStarted = false;

  // void _validateForm() {
  //   setState(() {
  //     _isFormValid = _formKey.currentState?.validate() ?? false;
  //   });
  // }

  void _validateForm() {
    signupViewModel.isFormValid.value =
        signupViewModel.formKey.currentState?.validate() ?? false;
  }

  // TextEditingController emailIdController = TextEditingController();
  final pinController = TextEditingController();
  LoginViewModel loginDataViewModel = Get.put(LoginViewModel());

  final _emailFocus = FocusNode();
  final _dobFocus = FocusNode();
  final _zipCodeFocus = FocusNode();
  bool isMobileOtpVerified = false;
  bool isEmailOtpVerified = false;

  String? signature;
  IndrayaniAppGLobal indrayaniAppGLobal = IndrayaniAppGLobal.instance;
  // get time zone

  @override
  void initState() {
    super.initState();
    _startTimerOnce();
    checkConnectivity();
    _listenOTP();
    loginDataViewModel.emailController =
        TextEditingController(text: widget.emailId);
  }

  //listen otp from sms
  void _listenOTP() async {
    await SmsAutoFill().listenForCode();
  }

  void _verifyOtp(String otp) {
    bool isValidOtp = otp.length == 4;
  }

  final focusNode = FocusNode();

  // static const borderColor = Colors.cyanAccent;
  bool isContainerVisible = false;
  bool isSubmitted = false;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    _emailFocus.dispose();
    _dobFocus.dispose();
    _zipCodeFocus.dispose();
    // loginDataViewModel.emailController.dispose();
    // cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InternetAwareWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            spaceWidget(height: 50.0),
            Center(
              // child: Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width > 600
              //           ? 5
              //           : MediaQuery.of(context).size.width > 400
              //               ? 10
              //               : 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width > 600
                        ? 140
                        : MediaQuery.of(context).size.width > 400
                            ? 120
                            : 80,
                    height: MediaQuery.of(context).size.width > 600
                        ? 140
                        : MediaQuery.of(context).size.width > 400
                            ? 120
                            : 80,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Logo/logo.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    //  child: Image.asset('assets/logo.png'), // Adjust the path to your logo image
                  ),
                  spaceWidget(
                      width: MediaQuery.of(context).size.width > 600
                          ? 1
                          : MediaQuery.of(context).size.width > 400
                              ? 3
                              : 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome to",
                        style: TextStyle(
                            color: Color.fromARGB(255, 1, 37, 58),
                            fontWeight: FontWeight.w300,
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? 32
                                : MediaQuery.of(context).size.width > 400
                                    ? 30
                                    : 20,
                            height: 1),
                      ),
                      Text(
                        "INDRAYANI",
                        style: TextStyle(
                            color: Color.fromARGB(255, 1, 37, 58),
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? 42
                                : MediaQuery.of(context).size.width > 400
                                    ? 35
                                    : 32,
                            fontWeight: FontWeight.w400,
                            height: 1),
                      )
                    ],
                  ),
                ],
              ),
              // ),
            ),
            spaceWidget(height: 20.0),
            Expanded(
              child: SingleChildScrollView(child: Obx(
                () {
                  return Form(
                    key: signupViewModel.formKey,
                    // key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 30.0,
                          right: 30.0),
                      //  padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : const ConstantText(
                                  text: "First Name *",
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                          !signupViewModel.isSubmitted.value
                              ? TextFormField(
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.allow(
                                  //       RegExp(r'[0-9]')), // Only allow digits
                                  //   LengthLimitingTextInputFormatter(
                                  //       10), // Limit input to 10 characters
                                  // ],
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction, // Auto-validate on user interaction
                                  controller:
                                      loginViewModel.firstNameController,
                                  validator: _validateName,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                      color: Colors.red,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                    labelStyle: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    errorMaxLines: 1,
                                    hintText: 'Enter First Name ',
                                    hintStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? 14
                                                : MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        400
                                                    ? 12
                                                    : 10,
                                        fontStyle: FontStyle.italic,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.9)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                  // onFieldSubmitted: (value) {
                                  //   _validateForm();
                                  //   setState(() {
                                  //     // Reset border color when user starts typing
                                  //   });
                                  // },
                                )
                              : SizedBox(
                                  height: 20.0,
                                ),
                          spaceWidget(height: 10.0),
                          signupViewModel.isSubmitted.value
                              ? Center(
                                  child: Container(
                                    child: const ConstantText(
                                      text: "ACCOUNT VERIFICATION",
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : const ConstantText(
                                  text: "Last Name *",
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                          signupViewModel.isSubmitted.value
                              ? SizedBox(
                                  height: 20.0,
                                )
                              : TextFormField(
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.allow(
                                  //       RegExp(r'[0-9]')), // Only allow digits
                                  //   LengthLimitingTextInputFormatter(
                                  //       10), // Limit input to 10 characters
                                  // ],
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction, // Auto-validate on user interaction
                                  controller: loginViewModel.lastNameController,
                                  validator: _validateName,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                      color: Colors.red,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                    labelStyle: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    errorMaxLines: 1,
                                    hintText: 'Enter Last Name ',
                                    hintStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? 14
                                                : MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        400
                                                    ? 12
                                                    : 10,
                                        fontStyle: FontStyle.italic,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.9)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                  // onFieldSubmitted: (value) {
                                  //   _validateForm();
                                  //   setState(() {
                                  //     // Reset border color when user starts typing
                                  //   });
                                  // },
                                ),
                          spaceWidget(height: 10.0),
                          const ConstantText(
                            text: "Mobile Number *",
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                          spaceWidget(height: 3.0),
                          TextFormField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')), // Only allow digits
                              LengthLimitingTextInputFormatter(
                                  10), // Limit input to 10 characters
                            ],
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction, // Auto-validate on user interaction
                            controller: loginViewModel.mobileNumberController,
                            validator: _validateMobileNumber,
                            // onChanged: (value) {
                            //   _validateForm();
                            //   setState(() {
                            //     // Reset border color when user starts typing
                            //   });
                            // },
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  color: Colors.red,
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.1),
                                labelStyle: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.1)),
                                errorMaxLines: 1,
                                hintText: 'Enter Mobile Number ',
                                hintStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 600
                                            ? 14
                                            : MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    400
                                                ? 12
                                                : 10,
                                    fontStyle: FontStyle.italic,
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.9)),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                suffixIcon: Obx(() {
                                  return signupViewModel.isSubmitted.value
                                      ? GestureDetector(
                                          onTap: () async {
                                            loginDataViewModel
                                                .passwordController.text = "";
                                            loginDataViewModel
                                                .passwordController
                                                .clear();
                                            if (!isMobileOtpVerified) {
                                              final signCode =
                                                  await SmsAutoFill()
                                                      .getAppSignature;
                                              print(
                                                  "App Signature--------------->$signCode");
                                              if (loginDataViewModel
                                                  .mobileNumberController
                                                  .text
                                                  .isNotEmpty) {
                                                showLoadingDialog();
                                                APIBaseModel<
                                                        Map<String,
                                                            dynamic>?>?
                                                    otpResponse =
                                                    await loginDataViewModel
                                                        .getOTPForEnteredMobileNumber(
                                                            userId: signupViewModel
                                                                    .signupDataModel
                                                                    ?.value
                                                                    ?.responseBody
                                                                    ?.userId ??
                                                                0,
                                                            mobileNumber:
                                                                loginDataViewModel
                                                                    .mobileNumberController
                                                                    .text);
                                                hideLoadingDialog();
                                                _resetAndStartTimer();
                                                // Form is valid, show OTP dialog
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    // _startTimerOnce();
                                                    return AlertDialog(
                                                      title: const Text(
                                                        'OTP',
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Please enter the OTP sent to your mobile number.',
                                                            style: TextStyle(
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          spaceWidget(
                                                              height: 16.0),
                                                          PinFieldAutoFill(
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            currentCode:
                                                                loginDataViewModel
                                                                    .passwordController
                                                                    .text,
                                                            controller:
                                                                loginDataViewModel
                                                                    .passwordController,
                                                            codeLength: 4,
                                                            decoration:
                                                                BoxLooseDecoration(
                                                              gapSpace: 10.0,
                                                              strokeColorBuilder:
                                                                  const FixedColorBuilder(
                                                                      Colors
                                                                          .transparent),
                                                              bgColorBuilder:
                                                                  FixedColorBuilder(Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2)),
                                                              radius: Radius
                                                                  .circular(
                                                                      10.0),
                                                            ),
                                                            onCodeChanged:
                                                                (value) {
                                                              loginDataViewModel
                                                                  .passwordController
                                                                  .text = value!;
                                                              print(loginDataViewModel
                                                                  .passwordController
                                                                  .text);
                                                            },
                                                          ),
                                                          spaceWidget(
                                                              height: 10.0),
                                                          Obx(() => Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            30.0,
                                                                        right:
                                                                            30.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .timer,
                                                                        size:
                                                                            20.0,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.5)),
                                                                    SizedBox(
                                                                        width:
                                                                            4),
                                                                    Text(
                                                                      "${(_remainingTime.value ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime.value % 60).toString().padLeft(2, '0')}",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                                          spaceWidget(
                                                              height: 20.0),
                                                          Obx(() =>
                                                              AnimatedSwitcher(
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          20.0,
                                                                      right:
                                                                          20.0),
                                                                  child:
                                                                      SizedBox(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    //  height: MediaQuery.of(context).size.height,
                                                                    key:
                                                                        UniqueKey(),
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        String mobileNumber = loginDataViewModel
                                                                            .passwordController
                                                                            .text;
                                                                        // if (mobileNumber
                                                                        //     .isNotEmpty) {
                                                                        //   // RegExp regex = RegExp(r'^[789]\d{8,9}$');
                                                                        //   // if (!regex.hasMatch(mobileNumber)) {
                                                                        //   Get.snackbar(
                                                                        //     backgroundColor:
                                                                        //         Colors.black,
                                                                        //     colorText:
                                                                        //         Colors.white,
                                                                        //     'Error',
                                                                        //     'Please enter a valid number',
                                                                        //     snackPosition:
                                                                        //         SnackPosition.BOTTOM,
                                                                        //   );
                                                                        //   return;
                                                                        // } else {
                                                                        if (_remainingTime.value ==
                                                                            0) {
                                                                          showLoadingDialog();
                                                                          APIBaseModel<Map<String, dynamic>?>?
                                                                              otpResponse =
                                                                              await loginDataViewModel.getOTPForEnteredMobileNumber(userId: signupViewModel.signupDataModel?.value?.responseBody?.userId ?? 0, mobileNumber: loginDataViewModel.mobileNumberController.text);
                                                                          hideLoadingDialog();
                                                                          _resetAndStartTimer();
                                                                          //   _startTimerOnce();
                                                                        } else {
                                                                          showLoadingDialog();
                                                                          String
                                                                              mobile =
                                                                              loginDataViewModel.mobileNumberController.text;
                                                                          print(
                                                                              "MOBILE _______$mobile");
                                                                          APIBaseModel<LoginDataModel?>?
                                                                              loginModel =
                                                                              await loginDataViewModel.verifyOTP(mobileNumberController: mobile, userId: signupViewModel.signupDataModel?.value?.responseBody?.userId ?? 0);
                                                                          hideLoadingDialog();
                                                                          await loginDataViewModel
                                                                              .storeLoginResponseInSharedPreferences();

                                                                          if (loginModel?.status ==
                                                                              true) {
                                                                            isMobileOtpVerified =
                                                                                true;
                                                                            Navigator.of(context).pop();
                                                                          }

                                                                          if (loginModel?.status == true && isEmailOtpVerified ||
                                                                              widget.isGoogleSignIn == true) {
                                                                            // isMobileOtpVerified =
                                                                            //     true;
                                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                                builder: (context) => //BottomNavigationBarWidget(bodyWidget:
                                                                                    HomeScreen()
                                                                                // )
                                                                                ));
                                                                            // Navigator.of(context)
                                                                            //     .pop();
                                                                          } else {
                                                                            Get.snackbar(
                                                                              backgroundColor: Colors.black,
                                                                              colorText: Colors.white,
                                                                              '',
                                                                              loginModel?.message ?? "Something went wrong",
                                                                              snackPosition: SnackPosition.BOTTOM,
                                                                            );
                                                                            return;
                                                                          }
                                                                        }
                                                                        // signupViewModel
                                                                        //     .checkForLoginSessionExists();
                                                                        //  String? signupSessionValue = IndrayaniAppGLobal
                                                                        //     .instance
                                                                        //     .preferences
                                                                        //     ?.getString(signupSession);
                                                                        // print(
                                                                        //     "Respnse ----------------->$signupSessionValue");

                                                                        //TODO: call login api

                                                                        //Get.offAll(HomeScreen());
                                                                        // }
                                                                      },
                                                                      child:
                                                                          ConstantText(
                                                                        text: _remainingTime.value ==
                                                                                0
                                                                            ? "RESEND OTP"
                                                                            : 'VERIFY',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                      style:
                                                                          ButtonStyle(
                                                                        splashFactory:
                                                                            InkRipple.splashFactory,
                                                                        overlayColor:
                                                                            MaterialStateProperty.resolveWith(
                                                                          (states) {
                                                                            return states.contains(MaterialState.pressed)
                                                                                ? Colors.grey
                                                                                : null;
                                                                          },
                                                                        ),
                                                                        backgroundColor: MaterialStateProperty.all(loginDataViewModel.isOTPVisible.value
                                                                            ? primaryColor
                                                                            : primaryColor),
                                                                        shape: MaterialStateProperty.all<
                                                                            RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0), // Set to 0 for square shape
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                Get.snackbar("Error",
                                                    'Please enter valid Mobile Number',
                                                    backgroundColor: Colors
                                                        .black
                                                        .withOpacity(0.6),
                                                    colorText: Colors.white,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    // duration: Duration(seconds: 2),
                                                    animationDuration:
                                                        Duration(seconds: 1));
                                                // Form is invalid, show a message
                                              }
                                            }
                                          },
                                          child:
                                              // Obx(() {
                                              //   return signupViewModel.isSubmitted.value
                                              //       ?
                                              Container(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                isMobileOtpVerified
                                                    ? const Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green)
                                                    // : loginDataViewModel
                                                    //         .isOtpRequestInProgressForMobile
                                                    //         .value
                                                    //     ? const SizedBox(
                                                    //         height: 25.0,
                                                    //         width: 25.0,
                                                    //         child:
                                                    //             CircularProgressIndicator(
                                                    //           backgroundColor:
                                                    //               primaryColor,
                                                    //         ),
                                                    //       )
                                                    : const Text(
                                                        'SEND OTP',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    4,
                                                                    44,
                                                                    76)),
                                                      ),
                                              ],
                                            ),
                                          )
                                          //       : Container();
                                          // }
                                          //)
                                          )
                                      : SizedBox();
                                })),
                          ),
                          spaceWidget(height: 10.0),
                          const ConstantText(
                            text: "Email ID *",
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            controller: loginDataViewModel.emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: _validateEmail,
                            // onChanged: (value) {
                            //   // _validateForm();
                            //   // setState(() {
                            //   //   // Reset border color when user starts typing
                            //   // });
                            // },
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                errorStyle: const TextStyle(color: Colors.red),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.1),
                                labelStyle: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                errorMaxLines: 1,
                                //  labelText: 'Enter Email Id *',
                                hintText: 'Enter Email ID',
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize:
                                        MediaQuery.of(context).size.width > 600
                                            ? 14
                                            : MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    400
                                                ? 12
                                                : 10,
                                    color: Colors.black.withOpacity(0.9)),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                suffixIcon: Obx(() {
                                  return signupViewModel.isSubmitted.value
                                      ? GestureDetector(
                                          onTap: widget.isGoogleSignIn == false
                                              ?
                                              // widget.emailId.isEmpty
                                              //     ?
                                              () async {
                                                  loginDataViewModel
                                                      .passwordController
                                                      .text = "";
                                                  loginDataViewModel
                                                      .passwordController
                                                      .clear();
                                                  if (!isEmailOtpVerified) {
                                                    if (loginDataViewModel
                                                        .emailController
                                                        .text
                                                        .isNotEmpty) {
                                                      loginDataViewModel
                                                          .passwordController
                                                          .clear();
                                                      showLoadingDialog();
                                                      APIBaseModel<
                                                              Map<String,
                                                                  dynamic>?>?
                                                          otpResponse =
                                                          await loginDataViewModel.getOTPForEnteredMobileNumber(
                                                              userId: signupViewModel
                                                                      .signupDataModel
                                                                      ?.value
                                                                      ?.responseBody
                                                                      ?.userId ??
                                                                  0,
                                                              emailId:
                                                                  loginDataViewModel
                                                                      .emailController
                                                                      .text);
                                                      hideLoadingDialog();
                                                      _resetAndStartTimer();
                                                      // Form is valid, show OTP dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          _startTimerOnce();
                                                          return AlertDialog(
                                                            title: const Text(
                                                              'OTP',
                                                              style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <Widget>[
                                                                const Text(
                                                                  'Please enter the OTP sent to your Email ID.',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                  ),
                                                                ),
                                                                spaceWidget(
                                                                    height:
                                                                        16.0),
                                                                PinFieldAutoFill(
                                                                  currentCode:
                                                                      loginDataViewModel
                                                                          .passwordController
                                                                          .text,
                                                                  controller:
                                                                      loginDataViewModel
                                                                          .passwordController,
                                                                  codeLength: 4,
                                                                  decoration:
                                                                      BoxLooseDecoration(
                                                                    gapSpace:
                                                                        10.0,
                                                                    strokeColorBuilder:
                                                                        const FixedColorBuilder(
                                                                            Colors.transparent),
                                                                    bgColorBuilder:
                                                                        FixedColorBuilder(Colors
                                                                            .grey
                                                                            .withOpacity(0.2)),
                                                                    radius: Radius
                                                                        .circular(
                                                                            10.0),
                                                                  ),
                                                                  enabled: true,
                                                                  onCodeChanged:
                                                                      (value) {
                                                                    // // loginDataViewModel
                                                                    // //     .passwordController
                                                                    // //     .text = value!;
                                                                    // // FocusScope.of(
                                                                    // //         context)
                                                                    // //     .unfocus();
                                                                    // if (value != null &&
                                                                    //     value.length ==
                                                                    //         4) {
                                                                    if (value !=
                                                                        null) {
                                                                      loginDataViewModel
                                                                          .passwordController
                                                                          .text = value;
                                                                    }

                                                                    // FocusScope.of(
                                                                    //         context)
                                                                    //     .unfocus();
                                                                    // }
                                                                  },
                                                                  onCodeSubmitted:
                                                                      (value) {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                  },
                                                                ),
                                                                spaceWidget(
                                                                    height:
                                                                        10.0),
                                                                Obx(
                                                                    () =>
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 30.0,
                                                                              right: 30.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Icon(Icons.timer, size: 20.0, color: Colors.black.withOpacity(0.5)),
                                                                              SizedBox(width: 4),
                                                                              Text(
                                                                                "${(_remainingTime.value ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime.value % 60).toString().padLeft(2, '0')}",
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )),
                                                                spaceWidget(
                                                                    height:
                                                                        20.0),
                                                                Obx(() =>
                                                                    AnimatedSwitcher(
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              500),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                20.0,
                                                                            right:
                                                                                20.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          //  height: MediaQuery.of(context).size.height,
                                                                          key:
                                                                              UniqueKey(),
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () async {
                                                                              String email1 = loginDataViewModel.emailController.text;
                                                                              if (email1.isEmpty) {
                                                                                // RegExp regex = RegExp(r'^[789]\d{8,9}$');
                                                                                // if (!regex.hasMatch(mobileNumber)) {
                                                                                Get.snackbar(
                                                                                  backgroundColor: Colors.black,
                                                                                  colorText: Colors.white,
                                                                                  'Error',
                                                                                  'Please enter a valid OTP',
                                                                                  snackPosition: SnackPosition.BOTTOM,
                                                                                );
                                                                                return;
                                                                              } else {
                                                                                if (_remainingTime.value == 0) {
                                                                                  showLoadingDialog();
                                                                                  APIBaseModel<Map<String, dynamic>?>? otpResponse = await loginDataViewModel.getOTPForEnteredMobileNumber(userId: signupViewModel.signupDataModel?.value?.responseBody?.userId ?? 0, emailId: loginDataViewModel.emailController.text);
                                                                                  hideLoadingDialog();
                                                                                  _resetAndStartTimer();
                                                                                } else {
                                                                                  showLoadingDialog();
                                                                                  APIBaseModel<LoginDataModel?>? signupModel = await loginDataViewModel.verifyOTP(emailController: email?.value, userId: signupViewModel.signupDataModel?.value?.responseBody?.userId ?? 0);
                                                                                  hideLoadingDialog();
                                                                                  await loginViewModel.storeLoginResponseInSharedPreferences();
                                                                                  if (signupModel?.status == true) {
                                                                                    isEmailOtpVerified = true;
                                                                                    Navigator.of(context).pop();
                                                                                    if (isMobileOtpVerified == true) {
                                                                                      // Navigator.of(context)
                                                                                      //     .pop();
                                                                                      Navigator.of(context).push(MaterialPageRoute(
                                                                                        builder: (context) =>
                                                                                            // BottomNavigationBarWidget(
                                                                                            //   bodyWidget:
                                                                                            HomeScreen(),
                                                                                        //),
                                                                                      ));
                                                                                      // isEmailOtpVerified =
                                                                                      //     true;
                                                                                    } else {
                                                                                      Get.snackbar(
                                                                                        backgroundColor: Colors.black,
                                                                                        colorText: Colors.white,
                                                                                        'Error',
                                                                                        signupModel?.message ?? "Something went wrong",
                                                                                        snackPosition: SnackPosition.BOTTOM,
                                                                                      );
                                                                                      return;
                                                                                    }
                                                                                  }
                                                                                }
                                                                                // signupViewModel
                                                                                //     .checkForLoginSessionExists();

                                                                                //TODO: call login api

                                                                                //Get.offAll(HomeScreen());
                                                                              }
                                                                            },
                                                                            child:
                                                                                ConstantText(
                                                                              text: _remainingTime.value == 0 ? "RESEND OTP" : 'VERIFY',
                                                                              color: Colors.black,
                                                                              fontSize: 16.0,
                                                                            ),
                                                                            style:
                                                                                ButtonStyle(
                                                                              splashFactory: InkRipple.splashFactory,
                                                                              overlayColor: MaterialStateProperty.resolveWith(
                                                                                (states) {
                                                                                  return states.contains(MaterialState.pressed) ? Colors.grey : null;
                                                                                },
                                                                              ),
                                                                              backgroundColor: MaterialStateProperty.all(loginDataViewModel.isOTPVisible.value ? primaryColor : primaryColor),
                                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(10.0), // Set to 0 for square shape
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      Get.snackbar("Error",
                                                          'Please enter valid Email ID',
                                                          backgroundColor:
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.6),
                                                          colorText:
                                                              Colors.white,
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          // duration: Duration(seconds: 2),
                                                          animationDuration:
                                                              Duration(
                                                                  seconds: 1));
                                                      // Form is invalid, show a message
                                                    }
                                                  }
                                                }
                                              : () {},
                                          child:
                                              // Obx(() {
                                              //   return signupViewModel.isSubmitted.value
                                              //       ?
                                              Container(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                isEmailOtpVerified == true ||
                                                        widget.isGoogleSignIn ==
                                                            true
                                                    //  ||
                                                    //         widget
                                                    //             .emailId.isNotEmpty
                                                    ? const Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green)
                                                    :
                                                    // : loginDataViewModel
                                                    //         .isOtpRequestInProgressForEmail
                                                    //         .value
                                                    //     ? const SizedBox(
                                                    //         height: 25.0,
                                                    //         width: 25.0,
                                                    //         child:
                                                    //             CircularProgressIndicator(
                                                    //           backgroundColor:
                                                    //               primaryColor,
                                                    //         ),
                                                    //       )
                                                    //     :
                                                    const Text(
                                                        'SEND OTP',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    4,
                                                                    44,
                                                                    76)),
                                                      ),
                                              ],
                                            ),
                                          )
                                          //       : Container();
                                          // })
                                          )
                                      : SizedBox();
                                })),
                          ),
                          spaceWidget(height: 10.0),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : const ConstantText(
                                  text: "Educational Qualification *",
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : TextFormField(
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.allow(
                                  //       RegExp(r'[0-9]')), // Only allow digits
                                  //   LengthLimitingTextInputFormatter(
                                  //       10), // Limit input to 10 characters
                                  // ],
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction, // Auto-validate on user interaction
                                  controller: loginViewModel
                                      .educationalQualificationController,
                                  validator: _validateED,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                      color: Colors.red,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                    labelStyle: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    errorMaxLines: 1,
                                    hintText:
                                        'Enter Educational Qualification ',
                                    hintStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? 14
                                                : MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        400
                                                    ? 12
                                                    : 10,
                                        fontStyle: FontStyle.italic,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.9)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                  // onFieldSubmitted: (value) {
                                  //   _validateForm();
                                  //   setState(() {
                                  //     // Reset border color when user starts typing
                                  //   });
                                  // },
                                ),
                          spaceWidget(height: 10.0),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : const ConstantText(
                                  text: "City *",
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : TextFormField(
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,

                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction, // Auto-validate on user interaction
                                  controller: loginViewModel.cityController,
                                  validator: _validateED,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                      color: Colors.red,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                    labelStyle: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    errorMaxLines: 1,
                                    hintText: 'Enter City ',
                                    hintStyle: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width >
                                              600
                                          ? 14
                                          : MediaQuery.of(context).size.width >
                                                  400
                                              ? 12
                                              : 10,
                                      fontStyle: FontStyle.italic,
                                      color: const Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.9),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 20.0,
                                    ),
                                  ),
                                  // onFieldSubmitted: (value) {
                                  //   _validateForm();
                                  //   setState(() {
                                  //     // Reset border color when user starts typing
                                  //   });
                                  // },
                                ),
                          spaceWidget(height: 10.0),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : const ConstantText(
                                  text: "District *",
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : TextFormField(
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,

                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction, // Auto-validate on user interaction
                                  controller:
                                      loginViewModel.disctrictController,
                                  validator: _validateED,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                      color: Colors.red,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                    labelStyle: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    errorMaxLines: 1,
                                    hintText: 'Enter District ',
                                    hintStyle: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width >
                                              600
                                          ? 14
                                          : MediaQuery.of(context).size.width >
                                                  400
                                              ? 12
                                              : 10,
                                      fontStyle: FontStyle.italic,
                                      color: const Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.9),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 20.0,
                                    ),
                                  ),
                                  // onFieldSubmitted: (value) {
                                  //   _validateForm();
                                  //   setState(() {
                                  //     // Reset border color when user starts typing
                                  //   });
                                  // },
                                ),
                          spaceWidget(height: 10.0),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : const ConstantText(
                                  text: "State *",
                                  fontSize: 12.0,
                                  // style: FontStyle.italic,
                                ),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : Obx(
                                  () => DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    items:
                                        loginDataViewModel.states.map((state) {
                                      return DropdownMenuItem<String>(
                                        value: state,
                                        child: Text(state),
                                      );
                                    }).toList(),
                                    hint: const ConstantText(
                                      text: 'Select State',
                                      fontStyle: FontStyle.italic,
                                    ),
                                    value: loginViewModel.selectedState.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return ''; // Display an error message if no state is selected
                                      }
                                      return null; // Return null if validation passes
                                    },
                                    onChanged: (value) {
                                      if (value != null) {
                                        loginViewModel.selectedState.value =
                                            value;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.1),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 10.0,
                                      ),
                                      // Error border
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: loginViewModel.selectedState
                                                          .value ==
                                                      null ||
                                                  loginViewModel.selectedState
                                                      .value!.isEmpty
                                              ? Colors.red
                                              : Colors.grey.withOpacity(0.1),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      // Default border
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                          spaceWidget(height: 10.0),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : const ConstantText(
                                  text: "Zip Code *",
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : TextFormField(
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')), // Only allow digits
                                    LengthLimitingTextInputFormatter(
                                        6), // Limit input to 6 characters
                                  ],
                                  controller: loginViewModel.zipcodeController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  // onFieldSubmitted: (value) {
                                  //   _validateForm();
                                  //   setState(() {
                                  //     // Reset border color when user starts typing
                                  //   });
                                  // },
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    errorStyle:
                                        const TextStyle(color: Colors.red),

                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),

                                    errorMaxLines: 1,
                                    // labelText: 'Enter Zip code *',
                                    hintText: 'Enter Zip Code',

                                    hintStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? 14
                                                : MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        400
                                                    ? 12
                                                    : 10,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black.withOpacity(0.9)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                  validator: _validateZipCode),
                          spaceWidget(height: 20.0),
                          signupViewModel.isSubmitted.value
                              ? SizedBox()
                              : Obx(() => AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      // height: MediaQuery.of(context).size.height * 0.06,
                                      key: UniqueKey(),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          _validateForm();
                                          if (signupViewModel
                                              .isFormValid.value) {
                                            signupViewModel.submit();
                                            loginDataViewModel.toggleVisibility;
                                            String appSignature =
                                                await SmsAutoFill()
                                                    .getAppSignature;
                                            APIBaseModel<SignUpDataModel?>?
                                                signupResponse =
                                                await signupViewModel.signUp(
                                                    gID: widget.gID,
                                                    appSignature: appSignature);

                                            print(
                                                "Sign response ==================>$signupResponse");
                                            print("GID  ${widget.gID}");
                                            // await signupViewModel
                                            //     .storeSignupResponseInSharedPreferences();
                                            final signResult = signupResponse
                                                    ?.responseBody?.userId ??
                                                0;
                                            print("signResult $signResult");
                                            if (signupResponse?.status ==
                                                true) {
                                              final signResult = signupResponse
                                                      ?.responseBody?.userId ??
                                                  0;
                                              print("signResult $signResult");

                                              signupViewModel.submit();
                                              Get.snackbar('',
                                                  signupResponse?.message ?? "",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.black
                                                      .withOpacity(0.7),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  colorText: Colors.white);
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             HomeScreen()));
                                            } else {
                                              Get.snackbar(
                                                  'Error',
                                                  signupResponse?.message ??
                                                      "Something went wrong",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.black
                                                      .withOpacity(0.7),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  colorText: Colors.white);
                                            }
                                          } else {
                                            Get.snackbar(
                                                'Error',
                                                // responseData?.message ??
                                                "Plese fill all details",
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor: Colors.black
                                                    .withOpacity(0.7),
                                                duration: Duration(seconds: 2),
                                                colorText: Colors.white);
                                          }
                                        },
                                        child: const Text(
                                          'SIGNUP',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          splashFactory:
                                              InkRipple.splashFactory,
                                          overlayColor:
                                              MaterialStateProperty.resolveWith(
                                            (states) {
                                              return states.contains(
                                                      MaterialState.pressed)
                                                  ? Colors.grey
                                                  : null;
                                            },
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            loginDataViewModel
                                                    .isGoogleVisible.value
                                                ? primaryColor
                                                : primaryColor,
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Set to 0 for square shape
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                          spaceWidget(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const ConstantText(
                                text: "ALREADY HAVE AN ACCOUNT! ",
                                fontSize: 12.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                                  loginDataViewModel.loginMobileNumberController
                                      .clear();
                                  loginDataViewModel.passwordController.clear();
                                },
                                child: const ConstantText(
                                  text: "LOGIN",
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 1, 37, 58),
                                ),
                              ),
                            ],
                          ),
                          spaceWidget(height: 10.0),
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
        extendBody: true,
      ),
    );
  }

  String? _validateMobileNumber(String? value) {
    //RegExp regex = RegExp(r'^[789]\d{8,9}$');
    RegExp regex = RegExp(r'^\d{10}$');

    if (value == null || value.isEmpty) {
      return '';
    } else if (value.length < 1) {
      return null; // Don't show any error message until 1 digit is entered
    } else if (!regex.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String? _validateED(String? value) {
    RegExp regex = RegExp(r'^[789]\d{8,9}$');

    if (value == null || value.isEmpty) {
      return '';
    }
    // else if (value.length < 1) {
    //   return null; // Don't show any error message until 1 digit is entered
    // } else if (!regex.hasMatch(value)) {
    //   return 'Please enter valid mobile number';
    // }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'First name should contain only alphabets';
    }
    return null;
  }

// Validation logic for the email field
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

// Validation logic for the date of birth field

// Validation logic for the zip code field
//   String? _validateZipCode(String? value) {
//     RegExp regex = RegExp(r'^\d{4,6}$');

//     if (value == null || value.isEmpty) {
//       return '';
//     } else if (value.length < 3) {
//       // Check if the entered value has less than 5 digits
//       return null; // Don't show any error message until 5 digits are entered
//     } else if (!regex.hasMatch(value)) {
//       return 'Please enter valid zip code';
//     }

//     return null; // Return null if the validation is successful
//   }
// }
  String? _validateZipCode(String? value) {
    RegExp regex =
        RegExp(r'^\d{6}$'); // Regular expression to match exactly 6 digits

    if (value == null || value.isEmpty) {
      return 'Zip code cannot be empty';
    } else if (!regex.hasMatch(value)) {
      return 'Zip code must be exactly 6 digits';
    }

    return null; // Return null if the validation is successful
  }
  // String? _validateZipCode(String? value) {
  //   RegExp regex = RegExp(r'^\d{4,6}$');

  //   if (value == null || value.isEmpty) {
  //     //  return 'Zip code cannot be empty';
  //   } else if (value.length < 4) {
  //     return 'Zip code must be at least 4 digits';
  //   } else if (value.length > 6) {
  //     return 'Zip code cannot be more than 6 digits';
  //   } else if (!regex.hasMatch(value)) {
  //     return 'Please enter a valid zip code';
  //   }

  //   return null; // Return null if the validation is successful
  // }

  void _startTimerOnce() {
    if (!_timerStarted) {
      _timerStarted = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_remainingTime.value > 0) {
          _remainingTime.value--;
        } else {
          _timer?.cancel();
          // Clear OTP field when the timer ends
          loginDataViewModel.passwordController.clear();
        }
      });
    }
  }

  void _resetAndStartTimer() {
    mobile.value = loginDataViewModel.mobileNumberController.text;
    email?.value = loginDataViewModel.emailController.text;
    _timer?.cancel(); // Cancel the existing timer
    _remainingTime.value = 120; // Reset the timer to 5 minutes
    loginDataViewModel.passwordController.clear(); // Clear the OTP field
    _timerStarted = false;
    _startTimerOnce(); // Start the timer again
  }
}
