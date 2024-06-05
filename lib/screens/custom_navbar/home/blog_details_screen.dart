import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/services/blog_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../models/blog_model.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogModel blogModel;
  BlogDetailScreen({Key? key, required this.blogModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * 0.4,
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 15.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 30.sp,
                            color: AppColors.primaryBlack,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                    stream: BlogServices().getBlogStream(blogModel.blogId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("loading..."),
                        );
                      }
                      var data = snapshot.data!;
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlogServices().likeAndDislikeBlog(blogModel.blogId);
                            },
                            child: data['favoriteIdsList'].contains(FirebaseAuth.instance.currentUser!.uid)
                                ? Icon(Icons.favorite, size: 25.sp, color: Colors.red)
                                : Icon(Icons.favorite_border, color: Colors.grey, size: 25.sp),
                          ),
                          SizedBox(width: 05),
                          Text(
                            data['favoriteIdsList'].length.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 25.h,
                            width: 30.w,
                            child: Image.asset('assets/share.png'),
                          )
                        ],
                      );
                    }),
                SizedBox(height: 10.h),
                Text(
                  blogModel.title,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 05.h),
                Text(
                  blogModel.description,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
