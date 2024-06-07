import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/controllers/user_controller.dart';
import 'package:blog_app/screens/custom_navbar/settings/change_password.dart';
import 'package:blog_app/screens/custom_navbar/settings/edit_profile.dart';
import 'package:blog_app/screens/custom_navbar/settings/widgets/profile_card.dart';
import 'package:blog_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_alert_dialog.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: TitleText(
          text: "My Account",
          color: AppColors.primaryWhite,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            userController.userModel!.image == ""
                ? Center(
                    child: CircleAvatar(
                      radius: 50.sp,
                      child: Icon(Icons.person, size: 50),
                      backgroundColor: AppColors.primaryColor,
                    ),
                  )
                : Center(
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundImage: NetworkImage(userController.userModel!.image),
                    ),
                  ),
            SizedBox(height: 15.h),
            Text(
              userController.userModel!.username,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.primaryBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 05),
            Text(
              "Member Since: ${DateFormat("dd-MM-yyyy").format(userController.userModel!.memberSince)}",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade900),
            ),
            SizedBox(height: 20),
            CustomProfileCard(
              iconData: Icons.account_circle,
              title: "Edit Profile",
              onTap: () {
                Get.to(() => EditProfileScreen());
              },
            ),
            CustomProfileCard(
              iconData: Icons.lock_reset,
              title: "Change Password",
              onTap: () {
                Get.to(() => ChangePasswordScreen());
              },
            ),
            // CustomProfileCard(
            //   iconData: Icons.light_mode,
            //   title: "Light Theme",
            //   onTap: () {
            //     Provider.of<ThemeProvider>(context, listen: false).toggleTheme(lightTheme);
            //   },
            // ),
            // CustomProfileCard(
            //   iconData: Icons.nights_stay_sharp,
            //   title: "Dark Theme",
            //   onTap: () {
            //     Provider.of<ThemeProvider>(context, listen: false).toggleTheme(darkTheme);
            //   },
            // ),
            CustomProfileCard(
              iconData: Icons.logout,
              title: "Logout",
              onTap: () {
                customAlertDialog(context, () {
                  AuthServices().logOut();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
