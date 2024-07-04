import 'package:cloud_firestore/cloud_firestore.dart';

class SizeModel {
  final String id;
  final String name;
  final String added;

  SizeModel({
    required this.id,
    required this.name,
    required this.added,
  });

  factory SizeModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return SizeModel(
      id: doc.id,
      name: doc['name'],
      added: doc['added'],
    );
  }
}
