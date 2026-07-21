import 'package:flutter/material.dart';

class BuyerData {
  String? id;
  DateTime? purchaseDate;

  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController addressController;
  TextEditingController quantityController;

  BuyerData({
    this.id,
    this.purchaseDate,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.quantityController,
  });
}