// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

// Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

// String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.companyId,
    this.createdAt,
    this.token,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? companyId;
  String? createdAt;
  String? token;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        companyId: json["company_id"],
        createdAt: json["created_at"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "company_id": companyId,
        "created_at": createdAt,
        "token": token,
      };
}
