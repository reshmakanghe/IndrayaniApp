import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Colors.orange),
    );
  }
}

void showLoadingDialog() {
  Get.dialog(
    LoadingDialog(),
    barrierDismissible: false,
  );
}

void hideLoadingDialog() {
  Get.back();
}
