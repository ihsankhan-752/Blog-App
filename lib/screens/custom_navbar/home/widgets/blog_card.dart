import 'package:blog_app/screens/custom_navbar/home/blog_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../models/blog_model.dart';

class BlogCard extends StatelessWidget {
  final BlogModel blogModel;
  const BlogCard({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
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
                child: CachedNetworkImage(
                  imageUrl: blogModel.blogImage,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
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
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(Icons.bookmark_border, size: 20, color: AppColors.primaryColor),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
