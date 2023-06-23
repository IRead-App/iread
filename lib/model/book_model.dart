import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel{
  final String name;
  final String image;
  final String author;
  final String kind;
  final String summary;
  final List<String> mainPoints;
  final String conclusion;

  BookModel({
    required this.name,
    required this.image,
    required this.author,
    required this.kind,
    required this.summary,
    required this.mainPoints,
    required this.conclusion,
  });

  factory BookModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return BookModel(
      name: json['name'],
      image: json['image'],
      author: json['author'],
      kind: json['kind'],
      summary: json['summary'],
      mainPoints: (json['mainPoints'] as List<dynamic>).cast<String>(),
      conclusion: json['conclusion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'author': author,
      'kind': kind,
      'summary': summary,
      'mainPoints': mainPoints,
      'conclusion': conclusion,
    };
  }
}