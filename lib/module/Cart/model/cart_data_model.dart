// class CartItem {
//   String? title;
//   String? difficulty;
//   String? id;
//   int? price;
//   String? imageUrl;
//   String? endDate;
//   String? optedDate;
//   int quantity;

//   CartItem({
//     this.title,
//     this.difficulty,
//     this.id,
//     this.price,
//     this.imageUrl,
//     this.quantity = 1,
//   });
// }
class CartItem {
  String? id;
  String? title;
  String? difficulty;
  String? exam_code;
  int? price;
  String? imageUrl;
  late int quantity;
  String? optedDate;
  String? endDate;
  String? transaction_id;
  String? order_id;
  String? banktrans_id;
  String? transaction_date;
  String? transaction_status;
  String? created_by;

  CartItem({
    this.id,
    this.title,
    this.difficulty,
    this.exam_code,
    this.price,
    this.imageUrl,
    this.quantity = 1,
    this.endDate,
    this.optedDate,
    this.transaction_id,
    this.order_id,
    this.banktrans_id,
    this.transaction_date,
    this.transaction_status,
    this.created_by,
  });
  get isUpcoming => true;
  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    difficulty = json['difficulty'];
    exam_code = json['exam_code'];
    price = json['price'];
    imageUrl = json['imageUrl&Time'];
    quantity = json['quantity'];
    endDate = json['endDate'];
    optedDate = json['optedDate'];
    transaction_id = json['transaction_id'];
    order_id = json['order_id'];
    banktrans_id = json['banktrans_id'];
    transaction_date = json['transaction_date'];
    transaction_status = json['transaction_status'];
    created_by = json['created_by'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['difficulty'] = this.difficulty;
    data['exam_code'] = this.exam_code;
    data['price'] = this.price;
    data['imageUrl&Time'] = this.imageUrl;
    data['quantity'] = this.quantity;
    data['endDate'] = this.endDate;
    data['optedDate'] = this.optedDate;
    data['transaction_id'] = this.transaction_id;
    data['order_id'] = this.order_id;
    data['banktrans_id'] = this.banktrans_id;
    data['transaction_date'] = this.transaction_date;
    data['transaction_status'] = this.transaction_status;
    data['created_by'] = this.created_by;
    return data;
  }
}
