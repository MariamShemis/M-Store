import 'package:cloud_firestore/cloud_firestore.dart';

class BuyerModel {
  static const String collectionName = "buyers";

  String id;

  String name;
  String phone;
  String address;

  int quantity;

  double price;

  DateTime purchaseDate;

  BuyerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.quantity,
    required this.price,
    required this.purchaseDate,
  });

  factory BuyerModel.fromJson(Map<String, dynamic> json) {
    return BuyerModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      quantity: json["quantity"] ?? 0,
      price: (json["price"] ?? 0).toDouble(),
      purchaseDate:
      (json["purchaseDate"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "address": address,
      "quantity": quantity,
      "price": price,
      "purchaseDate": Timestamp.fromDate(purchaseDate),
    };
  }
}