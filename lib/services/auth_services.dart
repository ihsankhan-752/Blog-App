import 'package:blog_app/widgets/custom_msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AuthServices {
  Future<void> login({required BuildContext context, required String email, required String password}) async {
    if (email.isEmpty) {
      showCustomMsg(context, "Email required");
    } else if (password.isEmpty) {
      showCustomMsg(context, 'Password required');
    } else {
      try {} on FirebaseException catch (e) {}
    }
  }
}
