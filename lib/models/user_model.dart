import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String studNo;
  final String college;
  final String course;
  final String status;

  UserModel({
    required this.name,
    required this.email,
    required this.studNo,
    required this.college,
    required this.course,
    required this.status,
  });

  // Factory constructor to instantiate object from json format
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      studNo: json["studNo"],
      course: json["course"],
      college: json["college"],
      status: json["status"],
    );
  }

  static List<UserModel> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<UserModel>((dynamic d) => UserModel.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(UserModel user) {
    return {
      "name": user.name,
      "email": user.email,
      "studNo": user.studNo,
      "college": user.college,
      "course": user.course,
      "status": user.status,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "studNo": studNo,
      "college": college,
      "course": course,
      "status": status,
    };
  }
}
