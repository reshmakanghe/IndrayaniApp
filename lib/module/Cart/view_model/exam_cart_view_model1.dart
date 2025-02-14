// import 'package:get/get.dart';

// import '../model/cart_data_model.dart';

// class CartViewModel extends GetxController {
//   var items = <CartItem>[].obs;

//   void addItem(CartItem item) {
//     final index = items.indexWhere((element) => element.exam_code == item.id);
//     if (index != -1) {
//     //  items[index].quantity = items[index].quantity + 1;
//     } else {
//       items.add(item);
//     }
//   }

//   void removeItem(String id) {
//     items.removeWhere((item) => item.id == id);
//   }

//   void updateItemQuantity(int id, int quantity) {
//     final index = items.indexWhere((item) => item.id == id);
//     if (index != -1) {
//       items[index].quantity = quantity;
//     }
//   }

//   double get totalAmount {
//     return items.fold(0.0, (total, current) => total + (current.price ?? 0) * current.quantity);
//   }

//   int get itemCount {
//     return items.length;
//   }
// }
