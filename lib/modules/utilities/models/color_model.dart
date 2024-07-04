import 'package:cloud_firestore/cloud_firestore.dart';

class ColorModel {
  final String id;
  final String name;
  final String added;

  ColorModel({
    required this.id,
    required this.name,
    required this.added,
  });

  factory ColorModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return ColorModel(
      id: doc.id,
      name: doc['name'],
      added: doc['added'],
    );
  }
}
