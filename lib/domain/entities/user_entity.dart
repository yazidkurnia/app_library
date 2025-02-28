// lib/domain/entities/user_entity.dart

class UserEntity {
  final String userId;
  final String email;
  final String username;
  final String role;
  final String collageCode;
  final String tempatLahir;
  final String tglLahir;
  final String alamatDomisili;
  final String token;

  UserEntity({
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
}
