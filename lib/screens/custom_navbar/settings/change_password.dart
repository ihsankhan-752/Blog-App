import 'package:blog_app/widgets/text_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/buttons.dart';
import '../../../constants/app_colors.dart';
import '../../../controllers/loading_controller.dart';
import '../../../controllers/visibility_controller.dart';
import '../../../services/auth_services.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.primaryWhite,
        ),
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Change Password",
          style: TextStyle(fontSize: 16, color: AppColors.primaryWhite, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(child: Icon(Icons.lock_open, color: AppColors.primaryColor, size: 100)),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Consumer<VisibilityController>(
                    builder: (context, passwordVisibilityController, child) {
                      return CustomTextField(
                        isSecureText: passwordVisibilityController.isOldPasswordVisible,
                        hintTitle: "Old Password",
                        iconData: Icons.password,
                        controller: _oldPasswordController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            passwordVisibilityController.toggleOldPasswordVisibility();
                          },
                          child: Icon(
                            passwordVisibilityController.isOldPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<VisibilityController>(
                    builder: (context, confirmPasswordVisibilityController, child) {
                      return CustomTextField(
                        isSecureText: confirmPasswordVisibilityController.isPasswordVisible,
                        hintTitle: "New Password",
                        iconData: Icons.password,
                        controller: _newPasswordController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            confirmPasswordVisibilityController.togglePasswordVisibility();
                          },
                          child: Icon(
                            confirmPasswordVisibilityController.isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<VisibilityController>(
                    builder: (context, confirmPasswordVisibilityController, child) {
                      return CustomTextField(
                        isSecureText: confirmPasswordVisibilityController.isConfirmPasswordVisible,
                        hintTitle: "Confirm",
                        iconData: Icons.password,
                        controller: _confirmPasswordController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            confirmPasswordVisibilityController.toggleConfirmPasswordVisibility();
                          },
                          child: Icon(
                            confirmPasswordVisibilityController.isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 50),
                  Consumer<LoadingController>(builder: (context, loadingController, child) {
                    return loadingController.isLoading
                        ? Center(
                            child: CircularProgressIndicator(color: AppColors.primaryColor),
                          )
                        : PrimaryButton(
                            onTap: () async {
                              AuthServices.changeUserPasswordCreative(
                                context: context,
                                oldPassword: _oldPasswordController.text,
                                newPassword: _newPasswordController.text,
                                confirmPassword: _confirmPasswordController.text,
                              );
                              setState(() {
                                _oldPasswordController.clear();
                                _newPasswordController.clear();
                                _confirmPasswordController.clear();
                              });
                            },
                            buttonTitle: "Change Password",
                          );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
