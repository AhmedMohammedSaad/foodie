import '../../domain/entities/user_entity.dart';

class AuthModel extends UserEntity {
  const AuthModel({
    required super.id,
    required super.email,
    super.name,
    super.profileImage,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      profileImage: json['profileImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImage': profileImage,
    };
  }
}
