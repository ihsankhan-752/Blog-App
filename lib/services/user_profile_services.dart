import 'dart:io';

import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/services/image_compress_services.dart';
import 'package:blog_app/services/storage_services.dart';
import 'package:blog_app/widgets/custom_msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserProfileServices {
  Future<void> updateProfile({required BuildContext context, File? image, String? username}) async {
    try {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);

      String? imageUrl;

      if (image != null) {
        File? _compressImage = await compressImage(image);
        imageUrl = await StorageServices().uploadPhoto(_compressImage);
      }

      Map<String, dynamic> data = {
        'username': username,
      };
      if (imageUrl != null) {
        data['image'] = imageUrl;
      }

      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(data);
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      Get.back();
    } on FirebaseException catch (e) {
      Provider.of<LoadingController>(context, listen: false).setLoading(false);

      showCustomMsg(context, e.message!);
    }
  }
}
