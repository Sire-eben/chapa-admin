// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String id;
  final String added;
  final String updated_at;
  final String product_id;
  final String user_name;
  final String rating;
  final String comment;

  factory ReviewModel.fromDocumentSnapshot(DocumentSnapshot json) {
    return ReviewModel(
      id: json.id,
      added: json['added'],
      updated_at: json['updated_at'],
      product_id: json['product_id'],
      user_name: json['name'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }

  ReviewModel(
      {required this.id,
      required this.added,
      required this.updated_at,
      required this.product_id,
      required this.user_name,
      required this.rating,
      required this.comment});
}
