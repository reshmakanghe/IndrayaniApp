class PaymenyHistoryDataModel {
  String? orderId;
  String? transactionDate;
  int? price;
  String? transactionStatus;
  String? examName;

  PaymenyHistoryDataModel(
      {this.orderId,
      this.transactionDate,
      this.price,
      this.transactionStatus,
      this.examName});

  PaymenyHistoryDataModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    transactionDate = json['transaction_date'];
    price = json['price'];
    transactionStatus = json['transaction_status'];
    examName = json['exam_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['transaction_date'] = this.transactionDate;
    data['price'] = this.price;
    data['transaction_status'] = this.transactionStatus;
    data['exam_name'] = this.examName;
    return data;
  }
}
