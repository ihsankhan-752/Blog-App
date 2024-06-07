import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/constants/lists.dart';
import 'package:blog_app/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../models/blog_model.dart';
import '../home/widgets/blog_card.dart';

class SavedBlogScreen extends StatefulWidget {
  SavedBlogScreen({Key? key}) : super(key: key);

  @override
  State<SavedBlogScreen> createState() => _SavedBlogScreenState();
}

class _SavedBlogScreenState extends State<SavedBlogScreen> {
  List<bool> isLovedList = List.generate(blogTitle.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.primaryWhite),
        title: TitleText(
          text: "Saved Blog",
          color: AppColors.primaryWhite,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userController.userModel!.bookMarkBlogs.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.25),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.note_alt, size: 80, color: AppColors.primaryColor),
                            SizedBox(height: 07),
                            Text(
                              "No Blogs Found",
                              style: TextStyle(
                                fontSize: 22,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('blogs')
                          .where(FieldPath.documentId, whereIn: userController.userModel!.bookMarkBlogs)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            BlogModel blogModel = BlogModel.fromMap(snapshot.data!.docs[index]);
                            return BlogCard(blogModel: blogModel);
                          },
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
