import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/screens/auth/login_screen.dart';
import 'package:blog_app/services/auth_services.dart';
import 'package:blog_app/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../widgets/buttons.dart';
import '../../widgets/text_inputs.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: EdgeInsets.fromLTRB(15.w, MediaQuery.of(context).padding.top, 15.w, 15.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Center(child: AppLogo(height: 80.h)),
                SizedBox(height: 10.h),
                TitleText(text: "Lets Get Started", color: AppColors.primaryBlack),
                SizedBox(height: 5.h),
                CustomTextField(
                  hintTitle: "Username",
                  controller: _usernameController,
                  iconData: Icons.person,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(height: 15.h),
                CustomTextField(
                  controller: _emailController,
                  hintTitle: "Email",
                  iconData: Icons.email,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(height: 15.h),
                CustomPasswordTextField(controller: _passwordController),
                SizedBox(height: 25.h),
                Consumer<LoadingController>(builder: (context, loadingController, child) {
                  return loadingController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(color: AppColors.primaryColor),
                        )
                      : PrimaryButton(
                          onTap: () {
                            AuthServices().signUp(
                              context: context,
                              username: _usernameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            setState(() {
                              _usernameController.clear();
                              _emailController.clear();
                              _passwordController.clear();
                            });
                          },
                          buttonTitle: "Next",
                        );
                }),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
