import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/screens/home/profile/change_password.dart';
import 'package:blog_app/screens/home/profile/edit_profile.dart';
import 'package:blog_app/screens/home/profile/invite_friends.dart';
import 'package:blog_app/screens/home/widgets/profile_card.dart';
import 'package:blog_app/theme/dark_theme.dart';
import 'package:blog_app/theme/light_theme.dart';
import 'package:blog_app/theme/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var auth = FirebaseAuth.instance;
  String userName = '';
  String userEmail = '';

  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      setState(() {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        userName = data["user name"];
        userEmail = data["email"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: TitleText(
          text: "My Account",
          color: AppColors.primaryWhite,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30.h),
                  color: Theme.of(context).colorScheme.primary,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60.h,
                            ),
                            TitleText(
                              text: userName,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SubTitleText(
                              text: userEmail,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomProfileCard(
                              iconData: Icons.account_circle,
                              text: "Edit Profile",
                              ontap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return EditProfile();
                                }));
                              },
                            ),
                            CustomProfileCard(
                              iconData: Icons.lock_reset,
                              text: "Change Password",
                              ontap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return ChangePassword();
                                }));
                              },
                            ),
                            CustomProfileCard(
                              iconData: Icons.light_mode,
                              text: "Light Theme",
                              ontap: () {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .toggleTheme(lightTheme);
                              },
                            ),
                            CustomProfileCard(
                              iconData: Icons.nights_stay_sharp,
                              text: "Dark Theme",
                              ontap: () {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .toggleTheme(darkTheme);
                              },
                            ),
                            CustomProfileCard(
                              iconData: Icons.send,
                              text: "Invite Friends",
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => InviteScreen()));
                              },
                            ),
                            CustomProfileCard(
                              iconData: Icons.question_mark_rounded,
                              text: "Contact Us",
                              ontap: () {},
                            ),
                            CustomProfileCard(
                              iconData: Icons.logout,
                              text: "Logout",
                              ontap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors
                            .primaryLightGrey, // Set the desired border color here
                        width: 1, // Set the desired border width here
                      ),
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: 50.sp,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
