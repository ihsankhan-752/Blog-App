import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/screens/auth/login_screen.dart';
import 'package:blog_app/widgets/app_logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  var auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future addUsersDetails(String username, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).set({
      'user name': username,
      'email': email,
      'uid': auth.currentUser!.uid,
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: EdgeInsets.fromLTRB(15.w, MediaQuery.of(context).padding.top, 15.w, 15.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                AppLogo(),
                SizedBox(
                  height: 10.h,
                ),
                TitleText(text: "Lets Get Started", color: Theme.of(context).colorScheme.primary),
                TitleText(text: "Sign Up", color: Theme.of(context).colorScheme.primary),
                SizedBox(
                  height: 25.h,
                ),
                CustomTextField(
                  hintTitle: "Username",
                  controller: _usernameController,
                  iconData: Icons.person,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  controller: _emailController,
                  hintTitle: "Email",
                  iconData: Icons.email,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomPasswordTextField(
                  controller: _passwordController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButton(
                  onTap: () async {
                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

                      await addUsersDetails(_usernameController.text.trim(), _emailController.text.trim());
                      // await FirebaseFirestore.instance
                      //     .collection("users")
                      //     .doc(auth.currentUser!.uid)
                      //     .set({
                      //   "uid": auth.currentUser!.uid,
                      //   "username": _usernameController.text,
                      //   "email": _emailController.text,
                      // });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign Up Successfully. Now you can login'),
                        ),
                      );
                    } catch (e) {
                      print(e.toString());
                    }

                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  buttonTitle: "Next",
                  width: double.infinity,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubTitleText(
                      text: "Already have an account",
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
