import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/auth_module/login/view_model/login_view_model.dart';
import 'package:indrayani/module/user_profile/model/user_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';

class UserDataViewModel extends GetxController {
  RxBool isEditClick = false.obs;
  Rx<APIBaseModel<UserDataModel?>?>? userDataModel =
      RxNullable<APIBaseModel<UserDataModel?>?>().setNull();

  Rx<APIBaseModel<List<UserDataModel?>?>?> userListDataModel =
      RxNullable<APIBaseModel<List<UserDataModel?>?>?>().setNull();

  LoginViewModel loginViewModel = Get.put(LoginViewModel());

  //get user details
  Future<APIBaseModel<List<UserDataModel?>?>?> getUsersDetails() async {
    userListDataModel.value =
        await APIService.getDataFromServer<List<UserDataModel?>?>(
      endPoint: userDetailsEndPoint,
      create: (dynamic json) {
        try {
          return (json as List).map((e) => UserDataModel.fromJson(e)).toList();
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    return userListDataModel.value;
  }

  //Update user details
  Future<APIBaseModel<UserDataModel?>?>? updateUserDetails() async {
    userDataModel?.value = await APIService.putDataToServer<UserDataModel?>(
        endPoint: updateUserDetailsEndPoint,
        body: {
          "first_name": loginViewModel.firstNameController.text,
          "last_name": loginViewModel.lastNameController.text,
          "email": loginViewModel.emailController.text,
          "mobile": loginViewModel.mobileNumberController.text,
          "education": loginViewModel.educationalQualificationController.text,
          "city": loginViewModel.cityController.text,
          "district": loginViewModel.disctrictController.text,
          "state": loginViewModel.stateController.text,
          "pin_code": loginViewModel.zipcodeController.text,

          //  "mobileSignature": appSignature
        },
        create: (dynamic json) {
          return UserDataModel.fromJson(json);
        });

    return userDataModel?.value;
  }
}
