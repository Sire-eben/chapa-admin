// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstname;
  final String lastname;
  final String image;
  final String email;
  final String phone;
  final String created_at;

  UserModel(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.image,
      required this.phone,
      required this.created_at});

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot json) {
    return UserModel(
      id: json.id,
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'] ?? "",
      created_at: json['created_at'],
    );
  }
}
