import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/screens/auth/sign_up_screen.dart';
import 'package:blog_app/screens/home/bottom_appbar.dart';
import 'package:blog_app/widgets/app_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // If login successful, navigate to home screen or any other destination.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomBottomAppBar()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle case when user is not found with given email
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        // Handle case when incorrect password is provided
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
      } else {
        // Handle other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.message}'),
          ),
        );
      }
    } catch (e) {
      // Handle other errors
      print(e.toString());
    }
  }

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
              PrimaryButton(
                onTap: () => _login(context),
                buttonTitle: "Login",
              ),
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
