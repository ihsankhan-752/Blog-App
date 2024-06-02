import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/screens/auth/forget_password.dart';
import 'package:blog_app/screens/auth/sign_up_screen.dart';
import 'package:blog_app/screens/home/bottom_appbar.dart';
import 'package:blog_app/widgets.dart';
import 'package:blog_app/widgets/app_logo.dart';
import 'package:blog_app/widgets/custom_button.dart';
import 'package:blog_app/widgets/custom_textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        padding:
            EdgeInsets.fromLTRB(15, MediaQuery.of(context).padding.top, 15, 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppLogo(),
              SizedBox(height: 10),
              TitleText(
                  text: "Welcome Back!",
                  color: Theme.of(context).colorScheme.primary),
              TitleText(
                  text: "Login", color: Theme.of(context).colorScheme.primary),
              SizedBox(height: 30),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    textButtonText: "Forgot Password?",
                    onclick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPassword()),
                      );
                    },
                    fontSize: 15,
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomButton(
                ontap: () => _login(context),
                // try {
                //   FirebaseAuth auth = FirebaseAuth.instance;
                //   await auth.signInWithEmailAndPassword(
                //       email: _emailController.text,
                //       password: _passwordController.text);
                // } catch (e) {
                //   print(e.toString());
                // }
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => CustomBottomAppBar()),
                // );

                buttontitle: "Login",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SubTitleText(
                    text: "Don't Have an account?",
                  ),
                  CustomTextButton(
                    textButtonText: "SignUp",
                    onclick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    fontSize: 16,
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
