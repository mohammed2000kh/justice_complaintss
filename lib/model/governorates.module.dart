// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
GovernoratesModel fromJson(String str) =>
    GovernoratesModel.fromJson(json.decode(str));

String toJson(GovernoratesModel data) => json.encode(data.toJson());

class GovernoratesModel {
  int id;
  String? code;
  String? name;

  GovernoratesModel({
    required this.id,
    this.code,
    this.name,
  });

  GovernoratesModel copyWith({
    int? idP,
    String? codeP,
    String? nameP,
  }) =>
      GovernoratesModel(
        id: idP ?? id,
        code: codeP ?? code,
        name: nameP ?? name,
      );

  factory GovernoratesModel.fromJson(Map<String, dynamic> json) =>
      GovernoratesModel(
        id: json["id"] ?? 0,
        code: json["governorate_code"],
        name: json["governorate_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "governorate_code": code,
        "governorate_name": name,
      };

  factory GovernoratesModel.fromMap(Map<String, dynamic> map) {
    return GovernoratesModel(
      id: map['id'] as int? ?? 0,
      code: map['governorate_code'] as String?,
      name: map['governorate_name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'governorate_code': code,
      'governorate_name': name,
    };
  }

  @override
  String toString() => 'GovernoratesModel(id: $id, code: $code, name: $name)';
}
