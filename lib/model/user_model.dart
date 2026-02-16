import 'package:flutter/foundation.dart';
import 'base_model.dart';

@immutable
class UserModel implements BaseModel {
  final String id;
  final String name;
  final String description;
  final String profileUrl;
  final List<String> skills;
  final List<String> requestedSkills;
  final String email;
  final bool isPremiumUser;

  const UserModel({
    required this.id,
    required this.name,
    required this.description,
    required this.profileUrl,
    required this.skills,
    required this.requestedSkills,
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
      requestedSkills: BaseModel.parseList<String>(
            json['requestedSkills'],
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
    List<String>? requestedSkills,
    bool? isProfileComplete,
    bool? isPremiumUser,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      profileUrl: profileUrl ?? this.profileUrl,
      skills: skills ?? this.skills,
      requestedSkills: requestedSkills ?? this.requestedSkills,
      email: email,
      isPremiumUser: isPremiumUser ?? this.isPremiumUser,
    );
  }
}

// Dummy data for testing and development
final List<UserModel> dummyUsers = [
  const UserModel(
    id: "u101",
    name: "Alice Carter",
    description: "Flutter Developer with 3 years experience",
    profileUrl: "https://example.com/profiles/alice.jpg",
    skills: ["Flutter", "Dart", "Firebase"],
    requestedSkills: ["Node.js", "System Design"],
    email: "alice.carter@example.com",
    isPremiumUser: false,
  ),
  const UserModel(
    id: "u102",
    name: "Brian Thompson",
    description: "Backend Engineer specializing in APIs",
    profileUrl: "https://example.com/profiles/brian.jpg",
    skills: ["Node.js", "Express", "MongoDB"],
    requestedSkills: ["Flutter", "UI/UX"],
    email: "brian.thompson@example.com",
    isPremiumUser: true,
  ),
  const UserModel(
    id: "u103",
    name: "Catherine Lee",
    description: "Machine Learning Enthusiast and Python Developer",
    profileUrl: "https://example.com/profiles/catherine.jpg",
    skills: ["Python", "TensorFlow", "Pandas"],
    requestedSkills: ["Data Engineering", "Cloud Computing"],
    email: "catherine.lee@example.com",
    isPremiumUser: false,
  ),
];
