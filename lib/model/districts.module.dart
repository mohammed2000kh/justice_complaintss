// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

DistrictsModel fromJson(String str) =>
    DistrictsModel.fromJson(json.decode(str));

String toJson(DistrictsModel data) => json.encode(data.toJson());

class DistrictsModel {
  int id;
  String code;
  String name;
  int governorateId;

  DistrictsModel({
    required this.id,
    required this.code,
    required this.name,
    required this.governorateId
  });

  DistrictsModel copyWith({
    int? idP,
    String? codeP,
    String? nameP,
    int? governorateIdP,
  }) =>
      DistrictsModel(
        id: idP ?? id,
        code: codeP ?? code,
        name: nameP ?? name,
        governorateId: governorateIdP ?? governorateId,
      );

  factory DistrictsModel.fromJson(Map<String, dynamic> json) =>
      DistrictsModel(
        id: json["id"] ?? 0,
        code: json["district_code"],
        name: json["district_name"],
        governorateId: json["governorate_id"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "district_code": code,
        "district_name": name,
        "governorate_id": governorateId,
      };

  factory DistrictsModel.fromMap(Map<String, dynamic> map) {
    return DistrictsModel(
      id: map['id'] as int,
      code: map['district_code'] as String,
      name: map['district_name'] as String,
      governorateId: map['governorate_id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'district_code': code,
      'district_name': name,
      'governorate_id': governorateId,
    };
  }

  @override
  String toString() {
    return 'DistrictsModel(id: $id, code: $code, name: $name, governorateId: $governorateId)';
  }
}
