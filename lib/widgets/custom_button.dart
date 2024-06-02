import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.ontap,
    required this.buttontitle,
    this.width,
    super.key,
  });
  VoidCallback ontap;
  double? width;

  String buttontitle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ontap,
        child: Container(
            height: 45,
            width: width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: TitleText(
                    text: buttontitle, color: AppColors.primaryWhite))));
  }
}
