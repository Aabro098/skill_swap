import 'package:flutter/foundation.dart';
import 'base_model.dart';

@immutable
class UserModel implements BaseModel {
  final String id;
  final String name;
  final String description;
  final String profileUrl;
  final List<String> skills;
  final String email;
  final bool isPremiumUser;

  const UserModel({
    required this.id,
    required this.name,
    required this.description,
    required this.profileUrl,
    required this.skills,
    required this.email,
    required this.isPremiumUser,
  });

  /// JSON → Model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: BaseModel.parseString(json['_id']) ?? '',
      name: BaseModel.parseString(json['name']) ?? '',
      description: BaseModel.parseString(json['description']) ?? '',
      profileUrl: BaseModel.parseString(json['profileurl']) ?? '',
      skills: BaseModel.parseList<String>(
            json['skills'],
            (e) => e.toString(),
          ) ??
          const [],
      email: BaseModel.parseString(json['email']) ?? '',
      isPremiumUser: BaseModel.parseBool(json['isPremiumUser']) ?? false,
    );
  }

  /// Optional: copyWith (you WILL need this later)
  UserModel copyWith({
    String? name,
    String? description,
    String? profileUrl,
    List<String>? skills,
    bool? isProfileComplete,
    bool? isPremiumUser,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      profileUrl: profileUrl ?? this.profileUrl,
      skills: skills ?? this.skills,
      email: email,
      isPremiumUser: isPremiumUser ?? this.isPremiumUser,
    );
  }
}
