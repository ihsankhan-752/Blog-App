import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  final String userId;
  final String blogId;
  final String blogImage;
  final String category;
  final String title;
  final String description;
  final List favoriteIdsList;
  final DateTime publishedOn;

  const BlogModel({
    required this.userId,
    required this.blogId,
    required this.blogImage,
    required this.category,
    required this.title,
    required this.description,
    required this.favoriteIdsList,
    required this.publishedOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'blogId': blogId,
      'blogImage': blogImage,
      'category': category,
      'title': title,
      'favoriteIdsList': favoriteIdsList,
      'description': description,
      'publishedOn': publishedOn,
    };
  }

  factory BlogModel.fromMap(DocumentSnapshot map) {
    return BlogModel(
      userId: map['userId'] as String,
      blogId: map['blogId'] as String,
      blogImage: map['blogImage'] as String,
      category: map['category'] as String,
      title: map['title'] as String,
      favoriteIdsList: map['favoriteIdsList'] as List,
      description: map['description'] as String,
      publishedOn: (map['publishedOn'].toDate()),
    );
  }
}
