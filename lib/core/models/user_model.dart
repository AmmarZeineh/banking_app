import 'package:banking_app/core/entities/user_entity.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String nationalId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isEmailVerified;
  final int roleId;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.nationalId,
    required this.createdAt,
    required this.updatedAt,
    required this.isEmailVerified,
    required this.roleId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      nationalId: json['nationalID'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isEmailVerified: json['isEmailVerified'],
      roleId: json['roleId'],
    );
  }

  Map<String, Object> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'nationalID': nationalId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'isEmailVerified': isEmailVerified,
    'roleId': roleId,
  };

  User toEntity() => User(
    id: id,
    name: name,
    email: email,
    nationalId: nationalId,
    isEmailVerified: isEmailVerified,
    roleId: roleId,
  );
}
