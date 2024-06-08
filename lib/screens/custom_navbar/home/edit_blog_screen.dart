import 'dart:io';

import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/controllers/image_controller.dart';
import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/services/blog_services.dart';
import 'package:blog_app/widgets/buttons.dart';
import 'package:blog_app/widgets/text_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_text_style.dart';
import '../../../constants/lists.dart';
import '../add_blog/widgets/show_options_for_image_picking.dart';

class EditBlogScreen extends StatefulWidget {
  final BlogModel blogModel;
  const EditBlogScreen({super.key, required this.blogModel});

  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  String? _selectedCategory;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.blogModel.title;
    _descriptionController.text = widget.blogModel.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(
          color: AppColors.primaryWhite,
        ),
        title: Text(
          "Edit Blog",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primaryWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Category",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton<String>(
                  hint: SubTitleText(
                    text: widget.blogModel.category,
                  ),
                  iconSize: 30,
                  isExpanded: true,
                  underline: SizedBox(),
                  value: _selectedCategory,
                  style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
                  onChanged: (String? newValue) async {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: tabList.map((String? newItem) {
                    return DropdownMenuItem<String>(
                      value: newItem,
                      child: Text(newItem!),
                    );
                  }).toList(),
                  itemHeight: 60,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Blog Image",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              imageController.selectedImage != null
                  ? Container(
                      height: 120.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(File(imageController.selectedImage!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                          ),
                          icon: Icon(Icons.delete_forever),
                          color: AppColors.primaryWhite,
                          onPressed: () {
                            imageController.clearUploadImage();
                          },
                        ),
                      ),
                    )
                  : Container(
                      height: 120.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(widget.blogModel.blogImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                          ),
                          icon: Icon(Icons.camera_alt),
                          color: AppColors.primaryWhite,
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
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              Text(
                "Title",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 05),
              CustomTextField(
                controller: _titleController,
                hintTitle: widget.blogModel.title,
              ),
              SizedBox(height: 20),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 05),
              CustomTextField(
                controller: _descriptionController,
                hintTitle: widget.blogModel.description,
                maxLines: 4,
              ),
              SizedBox(height: 30.h),
              Consumer<LoadingController>(builder: (context, loadingController, child) {
                return loadingController.isLoading
                    ? Center(child: CircularProgressIndicator(color: AppColors.primaryColor))
                    : PrimaryButton(
                        onTap: () {
                          BlogServices()
                              .updateBlog(
                            context: context,
                            blogId: widget.blogModel.blogId,
                            category: _selectedCategory == null ? widget.blogModel.category : _selectedCategory,
                            blogImage: imageController.selectedImage,
                            title: _titleController.text.isEmpty ? widget.blogModel.title : _titleController.text,
                            description:
                                _descriptionController.text.isEmpty ? widget.blogModel.description : _descriptionController.text,
                          )
                              .whenComplete(() {
                            imageController.clearUploadImage();
                            setState(() {
                              _titleController.clear();
                              _descriptionController.clear();
                            });
                          });
                        },
                        buttonTitle: "Update",
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
