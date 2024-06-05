import 'package:blog_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserController extends ChangeNotifier {
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  getUserInformation() async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots().listen((snap) {
      if (snap.exists) {
        _userModel = UserModel.fromMap(snap);
      } else {
        throw Exception("No Data Found");
      }
      notifyListeners();
    });
  }
}
