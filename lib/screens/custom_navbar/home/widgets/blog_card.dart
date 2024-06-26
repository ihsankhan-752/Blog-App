import 'package:blog_app/controllers/user_controller.dart';
import 'package:blog_app/screens/custom_navbar/home/blog_details_screen.dart';
import 'package:blog_app/services/blog_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../models/blog_model.dart';
import '../edit_blog_screen.dart';

class BlogCard extends StatelessWidget {
  final BlogModel blogModel;
  const BlogCard({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context).userModel;
    return GestureDetector(
      onTap: () {
        Get.to(() => BlogDetailScreen(blogModel: blogModel));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 150.h,
              width: Get.width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: blogModel.blogImage,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                    if (blogModel.userId != FirebaseAuth.instance.currentUser!.uid)
                      SizedBox()
                    else
                      Positioned(
                        top: 10,
                        right: 10,
                        child: PopupMenuButton(
                            iconColor: AppColors.primaryWhite,
                            onSelected: (v) async {
                              if (v == 'delete') {
                                await BlogServices().deleteBlog(context, blogModel.blogId);
                              }
                              if (v == 'edit') {
                                Get.to(() => EditBlogScreen(blogModel: blogModel));
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Text("Edit"),
                                  value: 'edit',
                                ),
                                PopupMenuItem(
                                  child: Text("Delete"),
                                  value: 'delete',
                                )
                              ];
                            }),
                      )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.8,
                    child: Text(
                      blogModel.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      BlogServices().addBlogToBookmark(context, blogModel.blogId);
                    },
                    child: userController!.bookMarkBlogs.contains(blogModel.blogId)
                        ? Icon(Icons.bookmark, color: AppColors.primaryColor, size: 25.sp)
                        : Icon(
                            Icons.bookmark_border,
                            size: 25.sp,
                            color: AppColors.primaryColor,
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
