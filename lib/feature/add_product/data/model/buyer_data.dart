import 'package:flutter/material.dart';

class BuyerData {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController phoneController;

  BuyerData({
    required this.nameController,
    required this.addressController,
    required this.phoneController,
  });
}