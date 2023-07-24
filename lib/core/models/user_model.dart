import 'package:delivery_app/core/models/product_model.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String role;
  final String email;
  List? brands;

  UserModel({
    required  this.firstName,
    required this.id,
    required this.lastName,
    required this.phone,
    required this.role,
    required this.email,
    this.brands
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['uid'],
      brands: json['brands'],
      firstName: json['firstName'],
      phone: json['phone'],
      role: json['role'],
      email: json['email'],
      lastName: json['lastName'],
    );
  }
}

