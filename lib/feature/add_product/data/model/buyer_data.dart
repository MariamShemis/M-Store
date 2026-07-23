import 'package:flutter/material.dart';

class BuyerData {
  String? id;
  DateTime? purchaseDate;

  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController addressController;
  TextEditingController quantityController;
  TextEditingController sellingPriceController;

  BuyerData({
    this.id,
    this.purchaseDate,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.quantityController,
    required this.sellingPriceController,
  });
}