import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const String collectionName = "products";

  String id;
  String productNumber;
  String productName;
  String description;
  String category;
  String material;
  String color;
  String dimensions;
  double purchasePrice;
  double sellingPrice;
  int quantity;
  int soldQuantity;
  int availableQuantity;
  List<String> images;
  DateTime createdAt;

  ProductModel({
    required this.id,
    required this.productNumber,
    required this.productName,
    required this.description,
    required this.category,
    required this.material,
    required this.color,
    required this.dimensions,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.quantity,
    required this.soldQuantity,
    required this.availableQuantity,
    required this.images,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? "",
      productNumber: json["productNumber"] ?? "",
      productName: json["productName"] ?? "",
      description: json["description"] ?? "",
      category: json["category"] ?? "",
      material: json["material"] ?? "",
      color: json["color"] ?? "",
      dimensions: json["dimensions"] ?? "",
      purchasePrice: (json["purchasePrice"] ?? 0).toDouble(),
      sellingPrice: (json["sellingPrice"] ?? 0).toDouble(),
      quantity: json["quantity"] ?? 0,
      soldQuantity: json["soldQuantity"] ?? 0,
      availableQuantity: json["availableQuantity"] ?? 0,
      images: List<String>.from(json["images"] ?? []),
      createdAt: (json["createdAt"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "productNumber": productNumber,
      "productName": productName,
      "description": description,
      "category": category,
      "material": material,
      "color": color,
      "dimensions": dimensions,
      "purchasePrice": purchasePrice,
      "sellingPrice": sellingPrice,
      "quantity": quantity,
      "soldQuantity": soldQuantity,
      "availableQuantity": availableQuantity,
      "images": images,
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }
}
