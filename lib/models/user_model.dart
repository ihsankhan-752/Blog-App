import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String username;
  final String image;
  final String email;
  final List bookMarkBlogs;
  final DateTime memberSince;

  UserModel({
    required this.email,
    required this.username,
    required this.userId,
    required this.image,
    required this.bookMarkBlogs,
    required this.memberSince,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userId': userId,
      'username': username,
      'image': image,
      'bookMarkBlogs': bookMarkBlogs,
      'memberSince': memberSince,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot snap) {
    return UserModel(
      email: snap['email'],
      username: snap['username'],
      image: snap['image'],
      userId: snap['userId'],
      bookMarkBlogs: snap['bookMarkBlogs'],
      memberSince: (snap['memberSince'].toDate()),
    );
  }
}
