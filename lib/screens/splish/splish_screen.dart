import 'dart:async';

import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return LoginScreen();
      }));
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
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          TitleText(
              text: "Powered by IKTEKSOL",
              color: Theme.of(context).colorScheme.primary)
        ],
      ),
    );
  }
}
