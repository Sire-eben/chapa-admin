// ignore_for_file: non_constant_identifier_names

import 'package:chapa_admin/modules/categories/models/quality.dart';
import 'package:chapa_admin/utils/parser_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'print_service.dart';
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
  final String design_price;
  final List<ItemQualityModel> qualities;
  final List<PrintServiceModel> printing_services;

  factory SubCategoriesModel.fromDocumentSnapshot(DocumentSnapshot json) {
    // final data = Map<String, dynamic>.from(json);
    return SubCategoriesModel(
      id: json.id,
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      cat_id: json['cat_id'] ?? "",
      added: json['added'] ?? "",
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
      qualities: json['qualities'] == null
          ? []
          : ParserUtil<ItemQualityModel>().parseJsonList2(
              json: json['qualities'],
              fromJson: (e) => ItemQualityModel.fromJson(e),
            ),
      printing_services: json['printing_services'] == null
          ? []
          : ParserUtil<PrintServiceModel>().parseJsonList2(
              json: json['printing_services'],
              fromJson: (e) => PrintServiceModel.fromJson(e),
            ),
    );
  }

  SubCategoriesModel({
    required this.id,
    required this.name,
    required this.cat_id,
    required this.color,
    required this.images,
    required this.size,
    required this.specifications,
    required this.description,
    required this.added,
    required this.design_price,
    required this.qualities,
    required this.printing_services,
  });
}
