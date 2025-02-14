import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/home/view_model/home_view_model.dart';
import 'package:indrayani/module/payment_history/view_model/payment_history_view_model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/custom_bottom_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final PaymentHistoryViewModel paymentHistoryViewModel =
      Get.put(PaymentHistoryViewModel());
  HomeDataViewModel homeDataViewModel = Get.put(HomeDataViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showLoadingDialog();
      await paymentHistoryViewModel.getPaymentHistoryList();
      hideLoadingDialog();
    });

    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final bottomBarVisibility =
            Get.find<NavigationController>().showBottomBar.value;
        return SafeArea(
          child: InternetAwareWidget(
            child: Scaffold(
              backgroundColor: bodyBGColor,
              appBar: const CustomAppBar(
                containerText: "PAYMENT HISTORY",
                imagePath: "assets/Payment1/icon.png",
              ),
              drawer: const UserDrawer(),
              body: Column(
                children: [
                  CustomPaint(
                    painter: HeaderCurvedContainer(),
                    child: SizedBox(
                      height: 10, // Set a specific height for the CustomPaint
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      if (paymentHistoryViewModel.paymenyHistoryListDataModel
                              .value?.responseBody?.isEmpty ??
                          true) {
                        return Center(
                          child: Animate(
                            child:
                                const ConstantText(text: "No Payment History!")
                                    .animate()
                                    .fadeIn(duration: 600.ms)
                                    .then(delay: 200.ms)
                                    .slide(),
                          ),
                        );
                      } else {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            double screenHeight = constraints.maxHeight;
                            double screenWidth = constraints.maxWidth;

                            return ListView.builder(
                              itemCount: paymentHistoryViewModel
                                      .paymenyHistoryListDataModel
                                      .value
                                      ?.responseBody
                                      ?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final item = paymentHistoryViewModel
                                    .paymenyHistoryListDataModel
                                    .value
                                    ?.responseBody?[index];

                                double cardPadding = screenWidth * 0.02;
                                double cardElevation =
                                    screenHeight > 800 ? 4 : 2;
                                double fontSize = screenHeight > 800 ? 16 : 14;
                                double amountFontSize =
                                    screenHeight > 800 ? 20 : 18;
                                double iconHeight = screenHeight * 0.04;

                                return Padding(
                                  padding: EdgeInsets.all(cardPadding),
                                  child: Card(
                                    elevation: cardElevation,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          dense: true,
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ConstantText(
                                                    text:
                                                        'Order Id - Ord#${item?.orderId ?? ""}',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: fontSize,
                                                  ),
                                                  ConstantText(
                                                    text:
                                                        'Order Date - ${homeDataViewModel.formatDate(item?.transactionDate ?? "")}',
                                                    fontSize: fontSize - 2,
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.01),
                                                  ConstantText(
                                                    text:
                                                        'INR ${item?.price ?? ""}',
                                                    fontSize: amountFontSize,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: iconHeight,
                                                    child: Image.asset(
                                                      item?.transactionStatus ==
                                                              "success"
                                                          ? 'assets/Payment1/icon1.png'
                                                          : 'assets/Payment1/Ro.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.005),
                                                  ConstantText(
                                                    text:
                                                        '${item?.transactionStatus ?? ""}',
                                                    color: Colors.black,
                                                    fontSize: fontSize - 2,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Set the border radius
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              dividerColor: Colors
                                                  .transparent, // Removes the border color
                                              expansionTileTheme:
                                                  ExpansionTileThemeData(
                                                collapsedBackgroundColor:
                                                    Colors.grey[200],
                                                backgroundColor:
                                                    Colors.grey[200],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                collapsedShape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            child: ExpansionTile(
                                              title: ConstantText(
                                                text: 'Details',
                                                fontSize: fontSize - 4,
                                              ),
                                              minTileHeight:
                                                  screenHeight * 0.025,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    bottom: Radius.circular(
                                                        10.0), // Round only the bottom corners
                                                  ),
                                                  child: ListTile(
                                                    tileColor: Colors.grey[200],
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ConstantText(
                                                          text:
                                                              'Transaction Date  :   ${homeDataViewModel.formatDate(item?.transactionDate ?? "")}',
                                                          fontSize: fontSize,
                                                        ),
                                                        if (item?.transactionDate !=
                                                            null)
                                                          ConstantText(
                                                            text:
                                                                'Order Date  :   ${homeDataViewModel.formatDate(item?.transactionDate ?? "")}',
                                                            fontSize: fontSize,
                                                          ),
                                                        SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.01),
                                                        const ConstantText(
                                                          text: 'Exams',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: ConstantText(
                                                      text:
                                                          '${item?.examName ?? ""}',
                                                      fontSize: fontSize,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    trailing: ConstantText(
                                                      text:
                                                          'INR ${item?.price ?? ""}',
                                                      fontSize: amountFontSize,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),
              bottomNavigationBar:
                  bottomBarVisibility ? CustomBottomNavBar() : null,
            ),
          ),
        );
      },
    );
  }
}
