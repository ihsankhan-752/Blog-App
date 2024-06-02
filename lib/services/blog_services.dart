import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/screens/custom_navbar/custom_navbar.dart';
import 'package:blog_app/widgets/custom_msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BlogServices {
  Future<void> addNewBlog({
    required BuildContext context,
    required String category,
    required String title,
    required String description,
  }) async {
    if (category.isEmpty) {
      showCustomMsg(context, "Please Choose category");
    } else if (title.isEmpty) {
      showCustomMsg(context, "Title required");
    } else if (description.isEmpty) {
      showCustomMsg(context, "Description required");
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);

        BlogModel blogModel = BlogModel(
          userId: FirebaseAuth.instance.currentUser!.uid,
          blogImage: "",
          category: category,
          title: title,
          description: description,
          publishedOn: DateTime.now(),
        );
        await FirebaseFirestore.instance.collection('blogs').add(blogModel.toMap());
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMsg(context, "Blog Uploaded");
        Get.offAll(() => CustomNavBar());
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);

        showCustomMsg(context, e.message!);
      }
    }
  }
}
