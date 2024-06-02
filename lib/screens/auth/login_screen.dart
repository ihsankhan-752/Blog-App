import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/screens/auth/sign_up_screen.dart';
import 'package:blog_app/services/auth_services.dart';
import 'package:blog_app/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_inputs.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, MediaQuery.of(context).padding.top, 15, 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              Center(child: AppLogo(height: 80.h)),
              SizedBox(height: 10),
              TitleText(text: "Welcome Back!", color: AppColors.primaryBlack),
              SizedBox(height: 20),
              CustomTextField(
                hintTitle: "Email",
                controller: _emailController,
                iconData: Icons.email,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(height: 20),
              CustomPasswordTextField(
                controller: _passwordController,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Consumer<LoadingController>(builder: (context, loadingController, child) {
                return loadingController.isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: AppColors.primaryColor),
                      )
                    : PrimaryButton(
                        onTap: () {
                          AuthServices()
                              .login(context: context, email: _emailController.text, password: _passwordController.text);
                          setState(() {
                            _emailController.clear();
                            _passwordController.clear();
                          });
                        },
                        buttonTitle: "Login",
                      );
              }),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUpScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
