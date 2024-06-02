import 'dart:io';

import 'package:blog_app/constants/app_colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/buttons.dart';
import '../../../widgets/text_inputs.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? selactedImage;

  getImageFromGallery() async {
    XFile? picketImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selactedImage = File(picketImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                          child: selactedImage == null
                              ? Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 50.sp,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(selactedImage!),
                                )),
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
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                getImageFromGallery();
                              },
                              icon: Icon(
                                Icons.mode_edit_sharp,
                                size: 20.sp,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  hintTitle: "Username",
                  iconData: Icons.person,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  hintTitle: "Email",
                  iconData: Icons.email,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButton(
                  onTap: () async {
                    try {
                      FirebaseStorage fs = FirebaseStorage.instance;
                      Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());

                      await ref.putFile(File(selactedImage!.path));

                      String url = await ref.getDownloadURL();
                    } catch (e) {
                      print(e);
                    }
                  },
                  buttonTitle: "Update",
                  width: double.infinity,
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ));
  }
}
