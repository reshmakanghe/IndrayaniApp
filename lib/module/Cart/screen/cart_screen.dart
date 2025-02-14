import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/Cart/view_model/exam_cart_view_model.dart';
import 'package:indrayani/module/payment_module/screen/thank_you_page.dart';
import 'package:indrayani/module/subscription_module/model/subscription_data_model.dart';
import 'package:indrayani/module/subscription_module/view_model/subscription_data_view_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/custom_bottom_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/exam_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartViewModel cartViewModel = Get.put(CartViewModel());

  SubscriptionDataViewModel subscriptionDataViewModel =
      Get.put(SubscriptionDataViewModel());

  final List<Color> colorPattern = [
    const Color.fromARGB(225, 255, 248, 209),
    const Color.fromARGB(255, 177, 220, 226), // Peach color
    const Color.fromARGB(255, 255, 172, 106),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final bottomBarVisibility =
            Get.find<NavigationController>().showBottomBar.value;
        return SafeArea(
          child: Scaffold(
            backgroundColor: bodyBGColor,
            appBar: const CustomAppBar(
              containerText: "MY CART",
              imagePath: "assets/Icon/cart-icon.png",
            ),
            drawer: const UserDrawer(),
            body: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  painter: HeaderCurvedContainer(),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
                Obx(
                  () => Column(
                    children: [
                      if (cartViewModel.items.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(
                              child: Column(
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Image.asset(
                                      'assets/My_Cart/empty-cart.png')),
                              const Text("No items in the cart"),
                            ],
                          )
                              // child: Text("No items in the cart")
                              ),
                        ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartViewModel.items.length,
                          itemBuilder: (context, index) {
                            final item = cartViewModel.items[index];
                            final color =
                                colorPattern[index % colorPattern.length];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ExamCard(
                                title: item.title,
                                difficulty: item.difficulty,
                                id: item.exam_code,
                                price: item.price,
                                imageUrl: item.imageUrl,
                                optedDate: item.optedDate,
                                endDate: item.endDate,
                                isTrending: item.isUpcoming,
                                isHomeScreen: false,
                                isCartScreen: true,
                                color: color,
                              ),
                            );
                          },
                        ),
                      ),
                      if (cartViewModel.items.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Padding(
                            //   padding: EdgeInsets.only(left: 16.0),
                            //   child: Text(
                            //     'PRICE DETAILS',
                            //     style: TextStyle(
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 16,
                            //     ),
                            //   ),
                            // ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 250, 237, 162)
                                    .withOpacity(0.5),
                                border: Border.all(
                                  color: Colors
                                      .black, // Specify the color of the border
                                  width: 0.5, // Specify the width of the border
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   height:
                                    //       MediaQuery.of(context).size.width *
                                    //           0.08,
                                    //   child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceEvenly,
                                    //       children: [
                                    //         const Text(
                                    //           "Items:",
                                    //           style: TextStyle(
                                    //               fontSize: 14,
                                    //               fontWeight: FontWeight.w400,
                                    //               color: Colors.black),
                                    //         ),
                                    //         Text(
                                    //           "${cartViewModel.itemCount}",
                                    //           style: TextStyle(
                                    //             fontSize: 14,
                                    //             fontWeight: FontWeight.w400,
                                    //           ),
                                    //         ),
                                    //       ]),
                                    // ),
                                    // const Divider(),
                                    // SizedBox(
                                    //   height:
                                    //       MediaQuery.of(context).size.width *
                                    //           0.08,
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceEvenly,
                                    //     children: [
                                    //       Text(
                                    //         "Total Amount:",
                                    //         style: TextStyle(
                                    //           fontSize: 14,
                                    //           fontWeight: FontWeight.w400,
                                    //         ),
                                    //       ),
                                    //       Text(
                                    //         "INR ${cartViewModel.totalAmount.toStringAsFixed(2)}",
                                    //         style: const TextStyle(
                                    //           fontSize: 14,
                                    //           fontWeight: FontWeight.w400,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 25.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Total Amount:",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "₹ ${cartViewModel.totalAmount.toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: MediaQuery.of(context)
                                        //           .size
                                        //           .width *
                                        //       0.65,
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .width *
                                        //       0.12,
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.only(
                                        //         left: 80.0, top: 13),
                                        //     child: Text(
                                        //       "INR ${cartViewModel.totalAmount.toStringAsFixed(2)}",
                                        //       style: const TextStyle(
                                        //         fontSize: 16,
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Colors.black,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, right: 25.0),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              List<String> examCodes =
                                                  cartViewModel.items
                                                      .map((item) =>
                                                          item.exam_code)
                                                      .where((code) =>
                                                          code != null)
                                                      .cast<String>()
                                                      .toList();
                                              double price = cartViewModel
                                                  .totalAmount
                                                  .toDouble();

                                              APIBaseModel<
                                                      SubscriptionDataModel?>?
                                                  response =
                                                  await subscriptionDataViewModel
                                                      .subscribeExams(
                                                          examCodes: examCodes,
                                                          price: price);

                                              // Handle checkout process
                                              if (response?.status == true) {
                                                cartViewModel.clearCart();
                                                Get.to(
                                                    () => const ThankYouPage());
                                              } else {
                                                Get.snackbar(
                                                  backgroundColor: Colors.black,
                                                  colorText: Colors.white,
                                                  'Error',
                                                  response?.message ??
                                                      "Something went wrong",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                );
                                                return;
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color
                                                  .fromARGB(255, 230, 159,
                                                  66), // Button background color
                                              minimumSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                              ), // Button size
                                            ),
                                            child: const Text(
                                              "Checkout",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.00, // Adjust height as needed
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar:
                bottomBarVisibility ? CustomBottomNavBar() : null,
          ),
        );
      },
    );
  }
}
