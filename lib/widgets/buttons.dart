import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? width;
  final String buttonTitle;
  PrimaryButton({required this.onTap, required this.buttonTitle, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: width,
        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: TitleText(text: buttonTitle, color: AppColors.primaryWhite),
        ),
      ),
    );
  }
}

class EditAndDeleteButton extends StatelessWidget {
  final Color? color;
  final String? title;
  final Function()? onPressed;
  const EditAndDeleteButton({super.key, this.color, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title!.toUpperCase(),
              style: TextStyle(
                color: AppColors.primaryWhite,
                fontSize: 13.sp,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
