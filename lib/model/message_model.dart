import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  final String sender;
  final String content;
  final Timestamp time;

  MessageModel({
    required this.sender,
    required this.content,
    required this.time,
  });

  factory MessageModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return MessageModel(
      sender: json['sender'],
      content: json['content'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'content': content,
      'time': time,
    };
  }
}