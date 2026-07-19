import 'package:flutter/material.dart';

class BuyerData {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController quantityController;

  BuyerData({
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.quantityController,
  });
}