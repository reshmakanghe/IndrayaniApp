import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/subscription_module/screen/subscription_screen.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
// import 'package:indrayani/module/Cart/view_model/exam_cart_view_model.dart';

// import 'package:indrayani/utils/common_widgets/home_custom_app_bar.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(
          SubscriptionScreen()); // Replace with the actual route name for the subscription screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bodyBGColor, // Ensure the same background color
        appBar: const CustomAppBar(
          containerText: "PAYMENT", // Update app bar title
          imagePath: "assets/Payment_Successful/icon.png",
        ),
        drawer: const UserDrawer(),
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter:
                  HeaderCurvedContainer(), // Use the same curved container painter
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Center(
                    child: Text(
                      'Thank You!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/Payment_Successful/Layer 15.png",
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    'Payment Successfull!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0BB811),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Navigate back to the home screen or product list screen
                  //     Get.offAllNamed('/'); // Replace with appropriate route
                  //   },
                  //   child: const Text('Back to Home'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
