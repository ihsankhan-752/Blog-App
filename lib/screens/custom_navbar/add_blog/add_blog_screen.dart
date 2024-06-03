import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/constants/lists.dart';
import 'package:blog_app/controllers/image_controller.dart';
import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/screens/custom_navbar/add_blog/widgets/image_uploading_widget.dart';
import 'package:blog_app/services/blog_services.dart';
import 'package:blog_app/widgets/custom_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../widgets/buttons.dart';
import '../../../widgets/text_inputs.dart';

class AddBlogScreen extends StatefulWidget {
  AddBlogScreen({Key? key}) : super(key: key);

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  String? _selectedCategory;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Add new Blog",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryLightGrey, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButton<String>(
                hint: SubTitleText(
                  text: "Please select category",
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
            SizedBox(height: 20.h),
            ImageUploadingWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  CustomTextField(
                    controller: _titleController,
                    iconData: Icons.edit_note,
                    hintTitle: "Blog Title",
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    controller: _descriptionController,
                    color: Theme.of(context).colorScheme.secondary,
                    iconData: Icons.note_alt,
                    hintTitle: "Blog Descriptions",
                    maxLines: 3,
                  ),
                  SizedBox(height: 40),
                  Consumer<LoadingController>(builder: (context, loadingController, child) {
                    return loadingController.isLoading
                        ? Center(
                            child: CircularProgressIndicator(color: AppColors.primaryColor),
                          )
                        : PrimaryButton(
                            onTap: () {
                              if (_selectedCategory != null) {
                                BlogServices().addNewBlog(
                                  image: imageController.selectedImage,
                                  context: context,
                                  category: _selectedCategory!,
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                );
                              } else {
                                showCustomMsg(context, "Please Select any category");
                              }

                              setState(() {
                                _titleController.clear();
                                _descriptionController.clear();
                              });
                              imageController.clearUploadImage();
                            },
                            buttonTitle: "Upload");
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
