import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/models/user_model.dart';
import 'package:blog_app/screens/home/home.dart';
import 'package:blog_app/widgets/custom_msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AuthServices {
  Future<void> signUp({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    if (username.isEmpty) {
      showCustomMsg(context, "username required");
    } else if (email.isEmpty) {
      showCustomMsg(context, "Email required");
    } else if (password.isEmpty) {
      showCustomMsg(context, 'Password required');
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        UserModel userModel = UserModel(
          email: email,
          username: username,
          userId: FirebaseAuth.instance.currentUser!.uid,
          favouriteBlogsId: [],
          memberSince: DateTime.now(),
        );

        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(userModel.toMap());
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        Get.to(() => Home());
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMsg(context, e.message!);

      }
    }
  }

  Future<void> login({required BuildContext context, required String email, required String password}) async {
    if (email.isEmpty) {
      showCustomMsg(context, "Email required");
    } else if (password.isEmpty) {
      showCustomMsg(context, 'Password required');
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Provider.of<LoadingController>(context, listen: false).setLoading(false);

        Get.to(() => Home());
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMsg(context, e.message!);
      }
    }
  }
}
