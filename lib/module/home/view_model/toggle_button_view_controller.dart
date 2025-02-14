import 'package:get/get.dart';
import 'package:indrayani/module/home/view_model/home_view_model.dart';
import 'package:pinput/pinput.dart';

class ToggleButtonsController extends GetxController {
  var isTrendingSelected = true.obs;
  HomeDataViewModel homeDataViewModel =
      Get.put(HomeDataViewModel()); // Observable variable

  void toggleButton() {
    isTrendingSelected.value = !isTrendingSelected.value;
    if (isTrendingSelected.value) {
      homeDataViewModel.trendingExamModels;
      // Get.find<HomeDataViewModel>().getTrendingExamList();
      homeDataViewModel.getTrendingExamList();
    } else {
      homeDataViewModel.trendingExamModels;
      // Get.find<HomeDataViewModel>().getUpcomingExamList();
      homeDataViewModel.getUpcomingExamList();
    }
  }
}
