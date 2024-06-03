import 'dart:io';

import 'package:blog_app/screens/custom_navbar/add_blog/widgets/show_options_for_image_picking.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../controllers/image_controller.dart';

class ImageUploadingWidget extends StatelessWidget {
  const ImageUploadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    if (imageController.selectedImage != null) {
      return Container(
        height: 100.h,
        width: Get.width - 30,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: FileImage(File(imageController.selectedImage!.path)),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                imageController.clearUploadImage();
              },
              child: Icon(Icons.close_outlined, color: Theme.of(context).colorScheme.error),
            ),
          ),
        ),
      );
    } else {
      return DottedBorder(
        strokeWidth: 2,
        color: Theme.of(context).colorScheme.secondary,
        dashPattern: [8, 4],
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        child: Container(
          height: 100.h,
          width: Get.width - 30,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      showOptionsForImagePicking(
                          context: context,
                          onGalleryClicked: () {
                            Get.back();
                            imageController.pickImage(ImageSource.gallery);
                          },
                          onCameraClicked: () {
                            Get.back();

                            imageController.pickImage(ImageSource.camera);
                          });
                    },
                    icon: SizedBox(
                      height: 35.h,
                      width: 200.w,
                      child: Image.asset('assets/upload.png'),
                    )),
                SizedBox(height: 05.h),
                Text(
                  "Add an Image",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
