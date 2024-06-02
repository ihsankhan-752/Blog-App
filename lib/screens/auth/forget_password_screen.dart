import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/buttons.dart';
import '../../widgets/text_inputs.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, MediaQuery.of(context).padding.top, 15, 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: "Forget password", color: Theme.of(context).colorScheme.primary),
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
                PrimaryButton(
                  onTap: () async {
                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.sendPasswordResetEmail(email: _emailController.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email has been sent successfully")));
                      // Fluttertoast.showToast(
                      //     msg: "Email has been sent successfully");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  buttonTitle: "Verify",
                ),
              ],
            ),
          ),
        ));
  }
}
