import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const String collectionName = "categories";

  String id;
  String name;
  DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      createdAt: (json["createdAt"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }
}