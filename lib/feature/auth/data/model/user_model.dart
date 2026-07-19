import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const String collectionName = "users";

  String id;
  String name;
  String email;
  String phone;

  String? image;
  String? birthday;
  String? gender;

  DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    this.birthday,
    this.gender,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      image: json["image"],
      birthday: json["birthday"],
      gender: json["gender"],
      createdAt: (json["createdAt"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "image": image,
      "birthday": birthday,
      "gender": gender,
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? birthday,
    String? gender,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}