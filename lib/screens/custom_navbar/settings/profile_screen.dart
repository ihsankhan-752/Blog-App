import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/screens/custom_navbar/settings/change_password.dart';
import 'package:blog_app/screens/custom_navbar/settings/edit_profile.dart';
import 'package:blog_app/screens/custom_navbar/settings/widgets/profile_card.dart';
import 'package:blog_app/services/auth_services.dart';
import 'package:blog_app/theme/dark_theme.dart';
import 'package:blog_app/theme/light_theme.dart';
import 'package:blog_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Center(
              child: CircleAvatar(
                radius: 50.sp,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            SizedBox(height: 20),
            CustomProfileCard(
              iconData: Icons.account_circle,
              title: "Edit Profile",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return EditProfile();
                }));
              },
            ),
            CustomProfileCard(
              iconData: Icons.lock_reset,
              title: "Change Password",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return ChangePasswordScreen();
                }));
              },
            ),
            CustomProfileCard(
              iconData: Icons.light_mode,
              title: "Light Theme",
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(lightTheme);
              },
            ),
            CustomProfileCard(
              iconData: Icons.nights_stay_sharp,
              title: "Dark Theme",
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(darkTheme);
              },
            ),
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
