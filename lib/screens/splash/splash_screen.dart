import 'dart:async';

import 'package:blog_app/screens/auth/login_screen.dart';
import 'package:blog_app/screens/custom_navbar/custom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAll(() => CustomNavBar());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 100.h,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
