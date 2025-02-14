import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

showToast({required String toastMessage}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: ConstantText(
    text: toastMessage,
  )));
}
