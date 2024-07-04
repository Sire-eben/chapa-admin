// ignore_for_file: non_constant_identifier_names

import 'package:chapa_admin/utils/parser_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'review_model.dart';

class SubCategoriesModel {
  final String id;
  final String name;
  final String cat_id;
  final List<String> color;
  final List<String> images;
  final List<String> size;
  final String specifications;
  final String description;
  final String added;
  final String higher_price;
  final String lower_price;
  final String design_price;
  final List<ReviewModel> reviews;

  factory SubCategoriesModel.fromDocumentSnapshot(DocumentSnapshot json) {
    // final data = Map<String, dynamic>.from(json);
    return SubCategoriesModel(
      id: json.id,
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      cat_id: json['cat_id'] ?? "",
      added: json['added'] ?? "",
      higher_price: json['higher_price'] ?? "",
      lower_price: json['lower_price'] ?? "",
      design_price: json['design_price'] ?? "",
      color: json['color'] == null
          ? []
          : (json['color'] as List<dynamic>)
              .map((e) => e?.toString() ?? "")
              .toList(),
      size: json['size'] == null
          ? []
          : (json['size'] as List<dynamic>)
              .map((e) => e?.toString() ?? "")
              .toList(),
      specifications: json['specifications'] ?? "",
      images: json['images'] == null
          ? []
          : (json['images'] as List<dynamic>)
              .map((e) => e?.toString() ?? "")
              .toList(),
      reviews: json['reviews'] == null
          ? []
          : ParserUtil<ReviewModel>().parseJsonList(
              json: json['reviews'],
              fromJson: (e) => ReviewModel.fromDocumentSnapshot(e),
            ),
    );
  }

  SubCategoriesModel(
      {required this.id,
      required this.name,
      required this.cat_id,
      required this.color,
      required this.images,
      required this.size,
      required this.specifications,
      required this.description,
      required this.added,
      required this.higher_price,
      required this.lower_price,
      required this.design_price,
      required this.reviews});
}


// List<IsusuModel>.from(
//             json['data'].map(
//               (e) => IsusuModel.fromJson(e),
//             ),
//           );