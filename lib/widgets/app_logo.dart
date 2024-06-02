import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;
  const AppLogo({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 150.h,
      width: width ?? 200.w,
      child: Image.asset("assets/logo.png"),
    );
  }
}
