import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:indrayani/module/auth_module/login/view_model/login_view_model.dart';
import 'package:indrayani/module/auth_module/signup/model/signup_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';
import 'package:indrayani/utils/constants/StringConstants/key_value_constant.dart';

import 'package:indrayani/utils/initialization_services/singleton_service.dart';

class SignupViewModel extends GetxController {
  Rx<APIBaseModel<SignUpDataModel?>?>? signupDataModel =
      RxNullable<APIBaseModel<SignUpDataModel?>?>().setNull();

  LoginViewModel loginViewModel = Get.put(LoginViewModel());

  final formKey = GlobalKey<FormState>();
  var isFormValid = false.obs;

  String? selectedCountryName;
  var isSubmitted = false.obs;
  var selectedState = RxnString();

  String timezone2 = "";
  DateTime dateTime = DateTime.now();

  void submit() {
    isSubmitted.value = true;
  }

  //sign up with secure code
  Future<APIBaseModel<SignUpDataModel?>?>? signUp(
      {String? appSignature, String? gID}) async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    print(deviceToken);
    String selectedState = loginViewModel.selectedState.value ?? '';

    signupDataModel?.value =
        await APIService.postDataToServer<SignUpDataModel?>(
            endPoint: signupEndPoint,
            body: {
              "first_name": loginViewModel.firstNameController.text,
              "last_name": loginViewModel.lastNameController.text,
              "email": loginViewModel.emailController.text,
              "mobile": loginViewModel.mobileNumberController.text,
              "education":
                  loginViewModel.educationalQualificationController.text,
              "city": loginViewModel.cityController.text,
              "district": loginViewModel.disctrictController.text,
              "state": selectedState,
              "pin_code": loginViewModel.zipcodeController.text,
              "fcm_token": deviceToken,
              "google_id": gID ?? ""
              //  "mobileSignature": appSignature
            },
            create: (dynamic json) {
              return SignUpDataModel.fromJson(json);
            });

    return signupDataModel?.value;
  }

  // Future<void> storeSignupResponseInSharedPreferences() async {
  //   print(
  //       "Token--------------->${signupDataModel?.value?.responseBody?.token}");
  //   if (signupDataModel?.value?.status == true) {
  //     await IndrayaniAppGLobal.instance.preferences?.setString(
  //         signupSession,
  //         jsonEncode(signupDataModel?.value?.toJson(
  //                     signupDataModel?.value?.responseBody?.toJson()) ??
  //                 {}
  //             // signupDataModel?.value
  //             //     ?.toJson((json) => json as Map<String, dynamic>),
  //             ));
  //   }
  //   return;
  // }

  // bool checkForLoginSessionExists() {
  //   String? signupSessionValue =
  //       IndrayaniAppGLobal.instance.preferences?.getString(signupSession);
  //   print("Respnse ----------------->$signupSessionValue");
  //   if (signupSessionValue != null) {
  //     IndrayaniAppGLobal.instance.signupViewModel.signupDataModel?.value =
  //         APIBaseModel.fromJson(
  //       jsonDecode(signupSessionValue),
  //       true,
  //       (json) {
  //         return SignUpDataModel.fromJson(json);
  //       },
  //     );
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // bool checkForLoginSessionExists() {
  //   String? signupSessionValue =
  //       IndrayaniAppGLobal.instance.preferences?.getString(signupSession);
  //   print("Response ----------------->$signupSessionValue");
  //   if (signupSessionValue != null) {
  //     Map<String, dynamic>? jsonData;
  //     try {
  //       jsonData = jsonDecode(signupSessionValue) as Map<String, dynamic>?;
  //     } catch (e) {
  //       print("Error decoding signup session JSON: $e");
  //     }

  //     if (jsonData != null) {
  //       IndrayaniAppGLobal.instance.signupViewModel.signupDataModel?.value =
  //           APIBaseModel.fromJson(
  //         jsonData,
  //         true,
  //         (json) => SignUpDataModel.fromJson(json as Map<String, dynamic>),
  //       );
  //       return true;
  //     }
  //   }
  //   return false;
  // }
}
