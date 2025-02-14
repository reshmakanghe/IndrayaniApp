import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

import 'package:indrayani/firebase_options.dart';
import 'package:indrayani/module/auth_module/login/screens/login_screen.dart';
import 'package:indrayani/module/auth_module/signup/screen/signup_screen.dart';

import 'package:indrayani/module/home/screens/home_screen.dart';

import 'package:indrayani/module/subscription_module/screen/subscription_screen.dart';

import 'package:indrayani/splash_screen.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/bottom_bar_widget/screen/bottom_bar_widget.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:indrayani/utils/constants/enum_constants.dart';
import 'package:indrayani/utils/initialization_services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavigationController());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseInitialization.sharedInstance.registerNotification();
  FirebaseInitialization.sharedInstance.configLocalNotification();

  APIConfig.setAPIConfigTo(environment: AppEnvironment.development);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Ping App',
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
          ),
        ),

//  initialRoute: '/home',
        routes: {
          '/subscription': (context) => SubscriptionScreen(),
          "/home": (BuildContext context) => HomeScreen(),
        },
        home: const SplashScreen());
  }
}
