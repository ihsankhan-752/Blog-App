import 'package:blog_app/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileCard extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  CustomProfileCard({required this.iconData, required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 15.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 60.h,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Icon(
              iconData,
              color: Theme.of(context).colorScheme.primary,
              size: 25.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            TitleText(
              text: text,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary,
              size: 20.sp,
            )
          ],
        ),
      ),
    );
  }
}
