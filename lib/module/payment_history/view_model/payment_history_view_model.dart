import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/home/model/home_data_model.dart';
import 'package:indrayani/module/payment_history/model/payment_history_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';

class PaymentHistoryViewModel extends GetxController {
  Rx<APIBaseModel<List<PaymenyHistoryDataModel?>?>?>
      paymenyHistoryListDataModel =
      RxNullable<APIBaseModel<List<PaymenyHistoryDataModel?>?>?>().setNull();

  Rx<APIBaseModel<List<PaymenyHistoryDataModel?>?>?> paymentDetails =
      RxNullable<APIBaseModel<List<PaymenyHistoryDataModel?>?>?>().setNull();

// get payment transaction list
  Future<APIBaseModel<List<PaymenyHistoryDataModel?>?>?>
      getPaymentHistoryList() async {
    paymenyHistoryListDataModel.value = await APIService
        .getDataFromServerWithoutErrorModel<List<PaymenyHistoryDataModel?>?>(
      endPoint: paymentHistoryEndPoint,
      create: (dynamic json) {
        try {
          return (json as List)
              .map((e) => PaymenyHistoryDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    // return null;
    return paymenyHistoryListDataModel.value;
  }
}
