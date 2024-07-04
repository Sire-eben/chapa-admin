import 'package:cloud_firestore/cloud_firestore.dart';

class PrintingServicesModel {
  final String id;
  final String name;
  final String price;
  final String unit;
  final String added;

  PrintingServicesModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.unit,
      required this.added});

  factory PrintingServicesModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return PrintingServicesModel(
        id: doc.id,
        name: doc['name'],
        price: doc['price'],
        unit: doc['unit'],
        added: doc['added']);
  }
}
