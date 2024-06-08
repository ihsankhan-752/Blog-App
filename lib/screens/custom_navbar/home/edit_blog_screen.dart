import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/models/blog_model.dart';
import 'package:flutter/material.dart';

class EditBlogScreen extends StatelessWidget {
  final BlogModel blogModel;
  const EditBlogScreen({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
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
      body: Column(
        children: [],
      ),
    );
  }
}
