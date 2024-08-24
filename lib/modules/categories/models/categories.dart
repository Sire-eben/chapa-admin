// ignore_for_file: non_constant_identifier_names

import 'package:chapa_admin/modules/categories/models/percentage_inc.dart';
import 'package:chapa_admin/utils/parser_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  final String id;
  final String name;
  final String url;
  final String design_price;
  final List<PercentageIncreaseModel> percentages;
  final String added;

  CategoriesModel(
      {required this.id,
      required this.name,
      required this.url,
      required this.design_price,
      required this.percentages,
      required this.added});

  factory CategoriesModel.fromDocumentSnapshot(DocumentSnapshot json) {
    return CategoriesModel(
      id: json.id,
      name: json['name'],
      url: json['url'],
      design_price: json['design_price'],
      percentages: json['percentages'] == null
          ? []
          : ParserUtil<PercentageIncreaseModel>().parseJsonList2(
              json: json['percentages'],
              fromJson: (e) => PercentageIncreaseModel.fromJson(e),
            ),
      added: json['added'],
    );
  }
}
