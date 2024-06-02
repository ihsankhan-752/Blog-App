import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/constants/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: TitleText(
            text: "Notifications",
            color: Theme.of(context).colorScheme.primary),
      ),
      body: ListView.separated(
        itemCount: communityLogos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(communityLogos[index]),
            ),
            title: Text(
              "Ihsan you followed uploaded a new blog",
              style: TextStyle(fontSize: 13.sp),
            ),
            trailing: Text(
              "2:00",
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: AppColors.primaryLightGrey,
          );
        },
      ),
    );
  }
}
