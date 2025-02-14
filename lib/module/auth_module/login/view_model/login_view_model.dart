import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:get/get.dart';
import 'package:indrayani/module/auth_module/login/model/login_data_model.dart';
import 'package:indrayani/module/auth_module/login/screens/login_screen.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';
import 'package:indrayani/utils/constants/StringConstants/key_value_constant.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';

class LoginViewModel extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  var isOTPVisible = true.obs;
  var isGoogleVisible = true.obs;
  var isGoogleSignIn = false.obs;
  Rx<APIBaseModel<LoginDataModel?>?>? loginDataModel =
      RxNullable<APIBaseModel<LoginDataModel?>?>().setNull();

  var isResendEnabled = false.obs;
  var resendText = 'Resend OTP'.obs;
  Timer? _timer;
  int _start = 30;
  final RxBool isOtpRequestInProgressForMobile = false.obs;
  final RxBool isOtpRequestInProgressForEmail = false.obs;

  //var selectedState = ''.obs;
  void initializeSelectedState(String? state) {
    selectedState.value = state ?? '';
  } // Timer duration in seconds

  var isContainerVisible = false.obs; // Observed variable
  var states = [
    '-',
    'Andaman and Nicobar Islands',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chandigarh',
    'Chhattisgarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Ladakh',
    'Lakshadweep',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Puducherry',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    // ... Add all your states here
  ].obs;

  // Selected state (initially set to null)
  var selectedState = RxnString();

  void setContainerVisible(bool value) {
    isContainerVisible.value = value; // Updating the value of observed variable
  }

  void toggleVisibility() {
    isOTPVisible.value = !isOTPVisible.value;
  }

  void toggleGoogleVisibility() {
    isGoogleVisible.value = !isGoogleVisible.value;
  }

  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController loginMobileNumberController =
      TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController educationalQualificationController =
      TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController disctrictController = TextEditingController();

  final TextEditingController timeController = TextEditingController();

  final otpControllers = List.generate(4, (index) => TextEditingController());
  String? selectedCountryName;

  String timezone2 = "";
  DateTime dateTime = DateTime.now();

  Future<APIBaseModel<Map<String, dynamic>?>?> getOTPForEnteredMobileNumber(
      {String? mobileNumber, String? emailId, int? userId}) async {
    //   isOtpRequestInProgress.value = true;

    return (
            // try {
            await APIService.postDataToServer<Map<String, dynamic>?>(
      endPoint: getOTPForEnteredMobileNumberEndPoint,
      body: {"mobile": mobileNumber, "email": emailId, "user_id": userId},
      create: (dynamic json) {
        return json;
      },
    )
        // } finally {
        //   // Stop the loading indicator
        //   isOtpRequestInProgress.value = false;
        // }
        );
  }
  // Future<APIBaseModel<Map<String, dynamic>?>?> getOTPForEnteredMobileNumber(
  //     {String? mobileNumber, String? emailId, int? userId}) async {
  //   // mobileNumber != ""
  //   //     ? isOtpRequestInProgressForMobile.value = true
  //   //     : isOtpRequestInProgressForEmail.value = false;
  //   // emailId != ""
  //   //     ? isOtpRequestInProgressForEmail.value = true
  //   //     : isOtpRequestInProgressForMobile.value = false;
  //   try {
  //     // Attempt to get the OTP by making a POST request to the server
  //     final response = await APIService.postDataToServer<Map<String, dynamic>?>(
  //       endPoint: getOTPForEnteredMobileNumberEndPoint,
  //       body: {"mobile": mobileNumber, "email": emailId, "user_id": userId},
  //       create: (dynamic json) {
  //         return json;
  //       },
  //     );

  //     // Return the response from the API
  //     return response;
  //   } catch (e) {
  //     // Handle any exceptions or errors here
  //     // Optionally, you can log the error or return a custom error model
  //     return null;
  //   } finally {
  //     // Ensure the loading indicator is turned off
  //     // isOtpRequestInProgressForEmail.value = false;
  //     // isOtpRequestInProgressForMobile.value = false;
  //   }
  // }

  Future<APIBaseModel<LoginDataModel?>?>? login(
      {String? mobileNumberController, String? gID, String? email}) async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    print(deviceToken);
    loginDataModel?.value = await APIService.postDataToServer<LoginDataModel?>(
        endPoint: loginEndPoint,
        body: {
          "mobile": mobileNumberController ?? "",
          "otp": passwordController.text,
          "fcm_token": deviceToken ?? "",
          "google_id": gID ?? "",
          "email": email ?? ""
        },
        create: (dynamic json) {
          if (json != null && json is Map<String, dynamic>) {
            return LoginDataModel.fromJson(json);
          }
          return null;
        });

    return loginDataModel?.value;
  }

  Future<APIBaseModel<LoginDataModel?>?>? getOtpForLogin(
      {String? mobileNumber}) async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    print(deviceToken);
    loginDataModel?.value = await APIService.postDataToServer<LoginDataModel?>(
        endPoint: loginEndPoint,
        body: {
          "mobile": loginMobileNumberController.text.isNotEmpty
              ? loginMobileNumberController.text
              : mobileNumber,
          "fcm_token": deviceToken
        },
        create: (dynamic json) {
          if (json != null && json is Map<String, dynamic>) {
            return LoginDataModel.fromJson(json);
          }
          return null;
        });

    return loginDataModel?.value;
  }

  Future<void> storeLoginResponseInSharedPreferences() async {
    print("Token--------------->${loginDataModel?.value?.responseBody?.token}");
    if (loginDataModel?.value?.status == true) {
      await IndrayaniAppGLobal.instance.preferences?.setString(
          loginSession,
          jsonEncode(
            loginDataModel?.value
                ?.toJson(loginDataModel?.value?.responseBody?.toJson()),
          ));
    }

    return;
  }

  bool checkForLoginSessionExists() {
    String? loginSessionValue =
        IndrayaniAppGLobal.instance.preferences?.getString(loginSession);
    print("Response ----------------->$loginSessionValue");
    if (loginSessionValue != null) {
      Map<String, dynamic>? jsonData;
      try {
        jsonData = jsonDecode(loginSessionValue) as Map<String, dynamic>?;
      } catch (e) {
        print("Error decoding signup session JSON: $e");
      }

      if (jsonData != null) {
        IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value =
            APIBaseModel.fromJson(
          jsonData,
          true,
          (json) => LoginDataModel.fromJson(json as Map<String, dynamic>),
        );
        return true;
      }
    }
    return false;
  }

  bool logoutUser() {
    IndrayaniAppGLobal.instance.preferences?.remove(loginSession);
    Navigator.of(Get.context!).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
    return true;
  }

  Future<APIBaseModel<LoginDataModel?>?>? verifyOTP(
      {String? mobileNumberController,
      String? emailController,
      int? userId}) async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    loginDataModel?.value = await APIService.postDataToServer<LoginDataModel?>(
        endPoint: verifyOtpEndPoint,
        body: {
          "otp": passwordController.text ?? "",
          "mobile": mobileNumberController ?? "",
          "email": emailController ?? "",
          "user_id": userId ?? 0,
          //"fcm_token": deviceToken ?? ""
        },
        create: (dynamic json) {
          if (json != null && json is Map<String, dynamic>) {
            return LoginDataModel.fromJson(json);
          }
          return null;
        });
    return loginDataModel?.value;
  }

  //sign up with secure code
  Future<APIBaseModel<Map<String, dynamic>?>?> signUp() async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();

    DateTime now = DateTime.now();

    // Get the UTC offset
    Duration offset = now.timeZoneOffset;

    // Format the UTC offset in the desired format (e.g., UTC+00:00)
    String utcOffsetString =
        'UTC${offset.isNegative ? '-' : '+'}${offset.inHours.abs().toString().padLeft(2, '0')}:${(offset.inMinutes % 60).abs().toString().padLeft(2, '0')}';

    print('UTC Offset: $utcOffsetString');

    return (await APIService.postDataToServer<Map<String, dynamic>?>(
        endPoint: signupEndPoint,
        body: {
          "mobile": mobileNumberController.text,
          "email": emailController.text,
          //  "dob": formattedDate,
          "country": selectedCountryName ?? "Switzerland",
          "zip_code": zipcodeController.text,
          "time_zone": utcOffsetString,
          "fcm_token": deviceToken
        },
        create: (dynamic json) {
          return json;
        }));
  }

  bool isAllFieldsFilled() {
    return mobileNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        educationalQualificationController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        zipcodeController.text.isNotEmpty;
  }

  bool validate() {
    // Check if mobile number is valid
    RegExp regex9Digits = RegExp(r'^\d{9}$');
    RegExp regex10Digits = RegExp(r'^\d{10}$');
    if (mobileNumberController.text.isEmpty ||
        (!regex9Digits.hasMatch(mobileNumberController.text) &&
            !regex10Digits.hasMatch(mobileNumberController.text))) {
      return false;
    }

    // Check if email is valid
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (emailController.text.isEmpty ||
        !emailRegex.hasMatch(emailController.text)) {
      return false;
    }

    // Check if ZIP code is valid
    RegExp zipRegex = RegExp(r'^\d{4,6}$');
    if (zipcodeController.text.isEmpty ||
        !zipRegex.hasMatch(zipcodeController.text)) {
      return false;
    }

    return true; // All fields are filled and pass validation
  }

// Login with Google

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignInn = GoogleSignIn();

  // static Future<User?> signInWithGoogle({required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;

  //   final GoogleSignIn googleSignIn = GoogleSignIn();

  //   final GoogleSignInAccount? googleSignInAccount =
  //       await googleSignIn.signIn();

  //   if (googleSignInAccount != null) {
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );

  //     try {
  //       final UserCredential userCredential =
  //           await auth.signInWithCredential(credential);

  //       user = userCredential.user;
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'account-exists-with-different-credential') {
  //         // handle the error here
  //       } else if (e.code == 'invalid-credential') {
  //         // handle the error here
  //       }
  //     } catch (e) {
  //       // handle the error here
  //     }
  //   }

  //   return user;
  // }
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    try {
      // Trigger the Google Sign-In process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // Sign-in was canceled by the user
        print("Google Sign-In canceled by user.");
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the new credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      print("Google Sign-In successful. User: ${user?.email}");
      return user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  // Future<User?> signInWithGoogle() async {
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await googleSignInn.signIn();
  //     if (googleUser == null) {
  //       // If the user cancels the sign-in, return null
  //       return null;
  //     }

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // Create a new credential
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Sign in to Firebase with the new credential
  //     final UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //     return userCredential.user;
  //   } catch (e) {
  //     print("Error during Google sign-in: $e");
  //     return null;
  //   }
  // }

  Future<void> signOutGoogle() async {
    await googleSignInn.signOut();
    print("User signed out of Google account");
  }

  //Resend otp timer

  void startTimer() {
    _start = 30; // Reset timer duration
    isResendEnabled.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start < 1) {
        timer.cancel();
        isResendEnabled.value = true;
        resendText.value = 'Resend OTP';
      } else {
        _start--;
        resendText.value = 'Login';
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
