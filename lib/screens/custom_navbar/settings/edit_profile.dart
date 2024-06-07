import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/controllers/image_controller.dart';
import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/controllers/user_controller.dart';
import 'package:blog_app/screens/custom_navbar/settings/widgets/image_picking_widget.dart';
import 'package:blog_app/services/user_profile_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../widgets/buttons.dart';
import '../../../widgets/text_inputs.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    final userController = Provider.of<UserController>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          title: Text(
            "Edit Profile",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Stack(
                    children: [
                      if (imageController.selectedImage == null && userController.userModel!.image == "")
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 50.sp,
                            ),
                          ),
                        ),
                      if (imageController.selectedImage == null && userController.userModel!.image != "")
                        CircleAvatar(
                          radius: 50.r,
                          backgroundImage: NetworkImage(userController.userModel!.image),
                        ),
                      if (imageController.selectedImage != null)
                        CircleAvatar(
                          radius: 55.r,
                          backgroundImage: FileImage(imageController.selectedImage!),
                        ),
                      Positioned(
                        right: 0.w,
                        bottom: 5.h,
                        child: Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryWhite,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x190013CE),
                                blurRadius: 4,
                                offset: Offset(0, 0),
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return imagePickingOptionDialog(
                                    onCameraClicked: () {
                                      Get.back();
                                      imageController.pickImage(ImageSource.camera);
                                    },
                                    onGalleryClicked: () {
                                      Get.back();
                                      imageController.pickImage(ImageSource.gallery);
                                    },
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: Icon(
                                Icons.mode_edit_sharp,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintTitle: userController.userModel!.username,
                  controller: _usernameController,
                  iconData: Icons.person,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(height: 40.h),
                Consumer<LoadingController>(builder: (context, loadingController, child) {
                  return loadingController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(color: AppColors.primaryColor),
                        )
                      : PrimaryButton(
                          onTap: () {
                            UserProfileServices().updateProfile(
                              context: context,
                              image: imageController.selectedImage,
                              username: _usernameController.text.isEmpty
                                  ? userController.userModel!.username
                                  : _usernameController.text,
                            );
                            imageController.clearUploadImage();
                            setState(() {
                              _usernameController.clear();
                            });
                          },
                          buttonTitle: "Update",
                          width: double.infinity,
                        );
                }),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ));
  }
}
