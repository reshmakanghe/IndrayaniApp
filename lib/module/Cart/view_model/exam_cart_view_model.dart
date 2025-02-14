import 'dart:convert'; // For JSON encoding/decoding
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_data_model.dart';

class CartViewModel extends GetxController {
  var items = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void addItem(CartItem item) {
    final index =
        items.indexWhere((element) => element.exam_code == item.exam_code);
    if (index != -1) {
      // Update quantity if needed
    } else {
      items.add(item);
    }
    saveCart(); // Save cart after adding an item
  }

  void removeItem(String id) {
    items.removeWhere((item) => item.exam_code == id);
    saveCart(); // Save cart after removing an item
  }

  void updateItemQuantity(String id, int quantity) {
    final index = items.indexWhere((item) => item.exam_code == id);
    if (index != -1) {
      items[index].quantity = quantity;
      saveCart(); // Save cart after updating item quantity
    }
  }

  double get totalAmount {
    return items.fold(0.0,
        (total, current) => total + (current.price ?? 0) * current.quantity);
  }

  int get itemCount {
    return items.length;
  }

  void saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItems =
        items.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('cart_items', cartItems);
  }

  void loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cart_items');
    if (cartItems != null) {
      items.value = cartItems.map((item) {
        final jsonData = json.decode(item);
        return CartItem.fromJson(jsonData);
      }).toList();
    }
  }

  // Method to clear the cart
  void clearCart() async {
    items.clear(); // Clear the items list
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .remove('cart_items'); // Remove the cart data from SharedPreferences
  }
}
