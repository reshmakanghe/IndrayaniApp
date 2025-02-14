import 'package:indrayani/module/auth_module/login/view_model/login_view_model.dart';
import 'package:indrayani/module/auth_module/signup/view_model/signup_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class IndrayaniAppGLobal {
  IndrayaniAppGLobal._privateConstructor();

  static IndrayaniAppGLobal instance = IndrayaniAppGLobal._privateConstructor();

  SharedPreferences? preferences;

  final LoginViewModel loginViewModel = Get.put(LoginViewModel());
  final SignupViewModel signupViewModel = Get.put(SignupViewModel());

  RxInt bottomNavigationBarSelectedIndex = 0.obs;

  void setBottomNavigationBarSelectedIndex() {}

  // Method to check if the token is saved
  bool isTokenSaved() {
    return preferences?.containsKey('token') ?? false;
  }
}
