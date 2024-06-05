import 'dart:io';

import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/screens/custom_navbar/custom_navbar.dart';
import 'package:blog_app/services/image_compress_services.dart';
import 'package:blog_app/services/storage_services.dart';
import 'package:blog_app/widgets/custom_msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BlogServices extends ChangeNotifier {
  Future<void> addNewBlog({
    required BuildContext context,
    File? image,
    required String category,
    required String title,
    required String description,
  }) async {
    if (image == null) {
      showCustomMsg(context, 'image required');
    } else if (title.isEmpty) {
      showCustomMsg(context, "Title required");
    } else if (description.isEmpty) {
      showCustomMsg(context, "Description required");
    } else {
      try {
        var blogId = const Uuid().v4();
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        File? _compressImage = await compressImage(image);
        String imageUrl = await StorageServices().uploadPhoto(_compressImage);

        BlogModel blogModel = BlogModel(
          blogId: blogId,
          userId: FirebaseAuth.instance.currentUser!.uid,
          blogImage: imageUrl,
          category: category,
          title: title,
          description: description,
          favoriteIdsList: [],
          publishedOn: DateTime.now(),
        );
        await FirebaseFirestore.instance.collection('blogs').doc(blogId).set(blogModel.toMap());
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMsg(context, "Blog Uploaded");
        Get.offAll(() => CustomNavBar());
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);

        showCustomMsg(context, e.message!);
      }
    }
  }

  addBlogToBookmark(BuildContext context, String blogId) async {
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

      if (snap['bookMarkBlogs'].contains(blogId)) {
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
          'bookMarkBlogs': FieldValue.arrayRemove([blogId]),
        });
      } else {
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
          'bookMarkBlogs': FieldValue.arrayUnion([blogId]),
        });
      }
    } on FirebaseException catch (e) {
      showCustomMsg(context, e.message!);
    }
  }

  Stream<DocumentSnapshot> getBlogStream(String blogId) {
    return FirebaseFirestore.instance.collection('blogs').doc(blogId).snapshots();
  }

  likeAndDislikeBlog(String blogId) async {
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection('blogs').doc(blogId).get();

      if ((snap['favoriteIdsList'] as List).contains(FirebaseAuth.instance.currentUser!.uid)) {
        await FirebaseFirestore.instance.collection('blogs').doc(blogId).update({
          'favoriteIdsList': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
        });
      } else {
        await FirebaseFirestore.instance.collection('blogs').doc(blogId).update({
          'favoriteIdsList': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
        });
      }
      notifyListeners();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
