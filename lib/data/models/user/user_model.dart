// lib/data/models/user/user_model.dart

import '../../../domain/entities/user_entity.dart';

class UserModel {
  final String userId;
  final String email;
  final String username;
  final String role;
  final String collageCode;
  final String tempatLahir;
  final String tglLahir;
  final String alamatDomisili;
  final String token;

  UserModel({
    required this.userId,
    required this.email,
    required this.username,
    required this.role,
    required this.collageCode,
    required this.tempatLahir,
    required this.tglLahir,
    required this.alamatDomisili,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userid'],
      email: json['email'],
      username: json['username'],
      role: json['role'],
      collageCode: json['collage_code'],
      tempatLahir: json['tempat_lahir'],
      tglLahir: json['tgl_lahir'],
      alamatDomisili: json['alamat_domisili'],
      token: json['token'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      email: email,
      username: username,
      role: role,
      collageCode: collageCode,
      tempatLahir: tempatLahir,
      tglLahir: tglLahir,
      alamatDomisili: alamatDomisili,
      token: token,
    );
  }
}
