import 'package:flutter/material.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Success'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepOrange,
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 60.0,
                  ),
                ),
              ),
              spaceWidget(height: 40.0),
              Text(
                'Payment Success!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              spaceWidget(height: 10.0),
              Text(
                'Your payment was processed successfully.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              spaceWidget(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
