import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: IconThemeData(color: AppColors.primaryWhite),
        centerTitle: true,
        title: TitleText(text: "Invite Friends", color: AppColors.primaryWhite),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/find.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SubTitleText(
                text: "Invite your Friends", color: AppColors.primaryBlack),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(ontap: () {}, buttontitle: "Invite"),
          ],
        ),
      ),
    );
  }
}

class CustomIcons extends StatelessWidget {
  CustomIcons({
    required this.iconData,
    required this.text,
    required this.ontap,
    super.key,
  });

  IconData iconData;
  String text;
  VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.grey.shade300, shape: BoxShape.circle),
            child: Center(
              child: IconButton(onPressed: ontap, icon: Icon(iconData)),
            ),
          ),
          TitleText(text: text, color: AppColors.primaryBlack)
        ],
      ),
    );
  }
}
