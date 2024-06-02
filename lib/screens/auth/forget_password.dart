import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/screens/auth/login_screen.dart';
import 'package:blog_app/widgets/custom_button.dart';
import 'package:blog_app/widgets/custom_textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              15, MediaQuery.of(context).padding.top, 15, 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                    text: "Forget password",
                    color: Theme.of(context).colorScheme.primary),
                SizedBox(
                  height: 10,
                ),
                SubTitleText(
                  text: "Enter your recovery email",
                ),
                SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  hintTitle: "Email",
                  controller: _emailController,
                  iconData: Icons.email,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(
                  height: 130,
                ),
                CustomButton(
                  ontap: () async {
                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.sendPasswordResetEmail(
                          email: _emailController.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Email has been sent successfully")));
                      // Fluttertoast.showToast(
                      //     msg: "Email has been sent successfully");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  buttontitle: "Verify",
                ),
              ],
            ),
          ),
        ));
  }
}
