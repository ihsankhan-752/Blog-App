import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/constants/lists.dart';
import 'package:blog_app/screens/custom_navbar/custom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/buttons.dart';
import '../../../widgets/text_inputs.dart';

class AddBlogScreen extends StatefulWidget {
  AddBlogScreen({Key? key}) : super(key: key);

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  String? _selectedItem;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        title: TitleText(text: "Add new Blog", color: Theme.of(context).colorScheme.primary),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {},
              child: DottedBorder(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.secondary,
                dashPattern: [8, 4],
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                child: Container(
                  height: 160.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.image_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 25.sp,
                            )),
                        SubTitleText(
                          text: "Add an Image",
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryLightGrey, width: 1), borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton<String>(
                      hint: SubTitleText(
                        text: "Please select category",
                      ),
                      dropdownColor: Theme.of(context).colorScheme.secondary,
                      iconSize: 30,
                      isExpanded: true,
                      underline: SizedBox(),
                      value: _selectedItem,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
                      onChanged: (String? newValue) async {
                        setState(() {
                          _selectedItem = newValue;
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
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    controller: _titleController,
                    iconData: Icons.mode,
                    hintTitle: "Add Title",
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    controller: _descriptionController,
                    color: Theme.of(context).colorScheme.secondary,
                    iconData: Icons.mode_rounded,
                    hintTitle: "Add Descriptions",
                  ),
                  SizedBox(
                    height: 180.h,
                  ),
                  PrimaryButton(
                      onTap: () async {
                        try {
                          await FirebaseFirestore.instance.collection("blogs").add({
                            "uid": FirebaseAuth.instance.currentUser!.uid,
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'category': _selectedItem
                          });
                        } catch (e) {
                          print(e);
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CustomNavBar()));
                      },
                      buttonTitle: "Upload"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
