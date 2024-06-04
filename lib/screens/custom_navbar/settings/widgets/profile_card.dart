import 'package:blog_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  CustomProfileCard({required this.iconData, required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 15.h),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 60.h,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Icon(iconData, color: AppColors.primaryColor, size: 25.sp),
            SizedBox(width: 10.w),
            Text(
              title,
              style: TextStyle(fontSize: 15.sp, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
