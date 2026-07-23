import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/buyer_model.dart';

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
  DateTime? updatedAt;

  double purchasePrice;

  int quantity;
  int soldQuantity;
  int availableQuantity;
  bool isSold;

  List<BuyerModel> buyers;

  String mainImage;
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
    required this.quantity,
    required this.soldQuantity,
    required this.availableQuantity,
    required this.isSold,
    required this.buyers,
    required this.images,
    this.updatedAt,
    required this.mainImage,
    required this.createdAt,
  });

  double buyerProfit(BuyerModel buyer) {
    return (buyer.sellingPrice - purchasePrice) * buyer.quantity;
  }

  double buyerTotalPrice(BuyerModel buyer) {
    return buyer.sellingPrice * buyer.quantity;
  }

  double get totalSellingPrice {
    return buyers.fold(0, (sum, buyer) => sum + buyerTotalPrice(buyer));
  }

  double get totalProfit {
    return buyers.fold(0, (sum, buyer) => sum + buyerProfit(buyer));
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? "",
      mainImage: json["mainImage"] ?? "",
      productNumber: json["productNumber"] ?? "",
      productName: json["productName"] ?? "",
      description: json["description"] ?? "",
      category: json["category"] ?? "",
      material: json["material"] ?? "",
      color: json["color"] ?? "",
      dimensions: json["dimensions"] ?? "",
      purchasePrice: (json["purchasePrice"] ?? 0).toDouble(),
      quantity: json["quantity"] ?? 0,
      soldQuantity: json["soldQuantity"] ?? 0,
      availableQuantity: json["availableQuantity"] ?? 0,
      images: List<String>.from(json["images"] ?? []),
      createdAt: (json["createdAt"] as Timestamp).toDate(),
      isSold: json["isSold"] ?? false,
      updatedAt: json["updatedAt"] != null
          ? (json["updatedAt"] as Timestamp).toDate()
          : null,
      buyers: (json["buyers"] as List? ?? [])
          .map((e) => BuyerModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "mainImage": mainImage,
      "productNumber": productNumber,
      "productName": productName,
      "description": description,
      "category": category,
      "material": material,
      "color": color,
      "dimensions": dimensions,
      "purchasePrice": purchasePrice,
      "quantity": quantity,
      "soldQuantity": soldQuantity,
      "availableQuantity": availableQuantity,
      "images": images,
      "createdAt": Timestamp.fromDate(createdAt),
      "isSold": isSold,
      "buyers": buyers.map((e) => e.toJson()).toList(),
      "updatedAt": updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

enum ProductFilter { all, available, sold }
