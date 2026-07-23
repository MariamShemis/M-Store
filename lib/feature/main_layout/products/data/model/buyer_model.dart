import 'package:cloud_firestore/cloud_firestore.dart';

class BuyerModel {
  String id;
  String name;
  String phone;
  String address;
  int quantity;
  double sellingPrice;
  DateTime? purchaseDate;

  BuyerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.quantity,
    required this.sellingPrice,
    this.purchaseDate,
  });

  factory BuyerModel.fromJson(Map<String, dynamic> json) {
    return BuyerModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      quantity: json["quantity"] ?? 0,
      sellingPrice: (json["sellingPrice"] ?? 0).toDouble(),
      purchaseDate: json["purchaseDate"] != null
          ? (json["purchaseDate"] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "address": address,
      "quantity": quantity,
      "sellingPrice": sellingPrice,
      "purchaseDate": purchaseDate == null
          ? null
          : Timestamp.fromDate(purchaseDate!),
    };
  }
}