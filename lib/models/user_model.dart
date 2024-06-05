import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String username;
  final String email;
  final List bookMarkBlogs;
  final DateTime memberSince;

  UserModel({
    required this.email,
    required this.username,
    required this.userId,
    required this.bookMarkBlogs,
    required this.memberSince,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userId': userId,
      'username': username,
      'bookMarkBlogs': bookMarkBlogs,
      'memberSince': memberSince,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot snap) {
    return UserModel(
      email: snap['email'],
      username: snap['username'],
      userId: snap['userId'],
      bookMarkBlogs: snap['bookMarkBlogs'],
      memberSince: (snap['memberSince'].toDate()),
    );
  }
}
