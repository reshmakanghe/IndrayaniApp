import 'package:get/get.dart';
import 'package:indrayani/module/home/view_model/home_view_model.dart';
import 'package:pinput/pinput.dart';

class ToggleButtonsController extends GetxController {
  var isTrendingSelected = true.obs; // Observable variable

  void toggleButton() {
    isTrendingSelected.value = !isTrendingSelected.value;
    if (isTrendingSelected.value) {
      Get.find<HomeDataViewModel>().getTrendingExamList();
    } else {
      Get.find<HomeDataViewModel>().getUpcomingExamList();
    }
  }
}
