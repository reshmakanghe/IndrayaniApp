import 'package:get/get.dart';
import 'package:indrayani/utils/constants/enum_constants.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';

class RxNullable<T> {
  Rx<T> setNull() => (null as T).obs;
}

class APIConfig {
  static String baseUrl = "";
  static String imagePath = "";
  static String infoImage = "";
  // LoginViewModel loginViewModel = Get.put(LoginViewModel());

  static setAPIConfigTo({required AppEnvironment environment}) {
    switch (environment) {
      case AppEnvironment.production:
        baseUrl = "";
        break;
      case AppEnvironment.development:
        baseUrl = "http://192.168.1.15:8000/api/"; //"http://3.110.51.62/api/";
        imagePath = "http://3.110.51.62/asset/exam_image/";
        infoImage = "http://3.110.51.62/asset/info_video_image/";
        //"http://192.168.1.10:8000/api/";
        //"http://192.168.0.123:8000/api/";
        break;
      case AppEnvironment.uat:
        baseUrl = "";
        break;
      case AppEnvironment.qa:
        baseUrl = "";
        break;
    }
  }

  static Map<String, String> getRequestHeader(
      {bool? encodeJson, String? authToken}) {
    Map<String, String> requestHeader = {
      "Content-Type": (encodeJson == false
          ? 'application/x-www-form-urlencoded'
          : "application/json")
    };
    //Set For Authorization token

    requestHeader["Authorization"] =
        "Bearer ${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.token}";

    return requestHeader;
  }
}
