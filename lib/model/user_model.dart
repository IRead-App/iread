import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iread/model/book_model.dart';

class UserModel {
  final String name;
  final String email;
  final String phone;
  final String country;
  final String gender;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.gender,
  });


  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>>  json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      country: json['country'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'country': country,
      'gender': gender,
    };
  }
}