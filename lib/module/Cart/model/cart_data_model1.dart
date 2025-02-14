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
  String? title;
  String? difficulty;
  String? id;
  int? price;
  String? imageUrl;
  int quantity;

  CartItem({
    this.title,
    this.difficulty,
    this.id,
    this.price,
    this.imageUrl = null,
    this.quantity = 1,
  });

  get optedDate => null;

  get endDate => null;

  get isSubscription => false;
}
