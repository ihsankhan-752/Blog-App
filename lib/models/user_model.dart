import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String username;
  final String email;
  final List favouriteBlogsId;
  final DateTime memberSince;

  UserModel({
    required this.email,
    required this.username,
    required this.userId,
    required this.favouriteBlogsId,
    required this.memberSince,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userId': userId,
      'username': username,
      'favouriteBlogsId': favouriteBlogsId,
      'memberSince': memberSince,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot snap) {
    return UserModel(
      email: snap['email'],
      username: snap['username'],
      userId: snap['userId'],
      favouriteBlogsId: snap['favouriteBlogsId'],
      memberSince: (snap['memberSince'].toDate()),
    );
  }
}
