import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  final String userId;
  final String blogImage;
  final String category;
  final String title;
  final String description;
  final DateTime publishedOn;

  const BlogModel({
    required this.userId,
    required this.blogImage,
    required this.category,
    required this.title,
    required this.description,
    required this.publishedOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'blogImage': blogImage,
      'category': category,
      'title': title,
      'description': description,
      'publishedOn': publishedOn,
    };
  }

  factory BlogModel.fromMap(DocumentSnapshot map) {
    return BlogModel(
      userId: map['userId'] as String,
      blogImage: map['blogImage'] as String,
      category: map['category'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      publishedOn: (map['publishedOn'].toDate()),
    );
  }
}
