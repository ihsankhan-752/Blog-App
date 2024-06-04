import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/lists.dart';
import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/screens/custom_navbar/add_blog/add_blog_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blogs",
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddBlogScreen());
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 45,
            width: Get.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _currentIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? AppColors.primaryColor : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          tabList[index],
                          style: TextStyle(
                            color: _currentIndex == index ? AppColors.primaryWhite : AppColors.primaryBlack,
                            fontSize: 14,
                            fontWeight: _currentIndex == index ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text("No Blogs Found"),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            BlogModel blogModel = BlogModel.fromMap(snapshot.data!.docs[index]);
                            return Card(
                              margin: EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Container(
                                    height: 150.h,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBlack,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(blogModel.blogImage),
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
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.bookmark_border, size: 20, color: AppColors.primaryColor),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
