import 'package:meta/meta.dart';
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.company,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.occupation,
  });

  String company;
  String email;
  String firstName;
  String lastName;
  String occupation;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    company: json["company"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    occupation: json["occupation"],
  );

  Map<String, dynamic> toJson() => {
    "company": company,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "occupation": occupation,
  };
}