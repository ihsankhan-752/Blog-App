import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          title: Text(
            "Reset Password",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.primaryBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, MediaQuery.of(context).padding.top, 15, 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: "Forget password?", color: AppColors.primaryBlack),
                SizedBox(height: 10),
                SubTitleText(
                  text: "Enter your recovery email",
                ),
                SizedBox(height: 25),
                CustomTextField(
                  hintTitle: "Email",
                  controller: _emailController,
                  iconData: Icons.email,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(height: 50),
                Consumer<LoadingController>(builder: (context, loadingController, child) {
                  return loadingController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(color: AppColors.primaryColor),
                        )
                      : PrimaryButton(
                          onTap: () {
                            AuthServices().resetPassword(context, _emailController.text);
                            setState(() {
                              _emailController.clear();
                            });
                          },
                          buttonTitle: "Submit",
                        );
                }),
              ],
            ),
          ),
        ));
  }
}
