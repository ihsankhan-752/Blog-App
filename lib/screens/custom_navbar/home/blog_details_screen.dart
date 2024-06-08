import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/services/blog_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../models/blog_model.dart';

class BlogDetailScreen extends StatefulWidget {
  final BlogModel blogModel;
  BlogDetailScreen({Key? key, required this.blogModel}) : super(key: key);

  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _likeAnimation;
  late Animation<Offset> _shareAnimation;
  late Animation<Offset> _imageAnimation;

  bool _showBigHeart = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _likeAnimation = Tween<Offset>(
      begin: Offset(-1.5, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _shareAnimation = Tween<Offset>(
      begin: Offset(1.5, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _imageAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('blogs').doc(widget.blogModel.blogId).get();
    List<dynamic> favoriteIdsList = snap['favoriteIdsList'];
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    if (!favoriteIdsList.contains(currentUserId)) {
      setState(() {
        _showBigHeart = true;
      });
      await BlogServices().likeAndDislikeBlog(widget.blogModel.blogId);
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _showBigHeart = false;
        });
      });
    } else {
      setState(() {});
      await BlogServices().likeAndDislikeBlog(widget.blogModel.blogId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(
                position: _imageAnimation,
                child: Container(
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
                          imageUrl: widget.blogModel.blogImage,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                ),
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 25.r,
                                  color: AppColors.primaryWhite,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: BlogServices().getBlogStream(widget.blogModel.blogId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("loading..."),
                          );
                        }
                        var data = snapshot.data!;
                        return Row(
                          children: [
                            SlideTransition(
                              position: _likeAnimation,
                              child: GestureDetector(
                                onTap: _toggleFavorite,
                                child: Icon(
                                  data['favoriteIdsList'].contains(FirebaseAuth.instance.currentUser!.uid)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 25.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            SlideTransition(
                              position: _likeAnimation,
                              child: Text(
                                data['favoriteIdsList'].length.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            Spacer(),
                            SlideTransition(
                              position: _shareAnimation,
                              child: GestureDetector(
                                onTap: () async {
                                  final box = context.findRenderObject() as RenderBox?;
                                  await Share.share(
                                    widget.blogModel.title,
                                    subject: widget.blogModel.description,
                                    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                                  );
                                },
                                child: SizedBox(
                                  height: 25.h,
                                  width: 30.w,
                                  child: Image.asset(
                                    'assets/share.png',
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      widget.blogModel.title,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      widget.blogModel.description,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          if (_showBigHeart)
            Center(
              child: AnimatedOpacity(
                opacity: _showBigHeart ? 0.5 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 100.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
