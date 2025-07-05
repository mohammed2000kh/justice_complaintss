// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

SubDistrictsModel fromJson(String str) =>
    SubDistrictsModel.fromJson(json.decode(str));

String toJson(SubDistrictsModel data) => json.encode(data.toJson());

class SubDistrictsModel {
  int id;
  String? code;
  String? name;
  int? districtId;

  SubDistrictsModel({
    required this.id,
    this.code,
    this.name,
    this.districtId,
  });

  SubDistrictsModel copyWith({
    int? idP,
    String? codeP,
    String? nameP,
    int? districtIdP,
  }) =>
      SubDistrictsModel(
        id: idP ?? id,
        code: codeP ?? code,
        name: nameP ?? name,
        districtId: districtIdP ?? districtId,
      );

  factory SubDistrictsModel.fromJson(Map<String, dynamic> json) =>
      SubDistrictsModel(
        id: json["id"] ?? 0,
        code: json["subdistrict_code"],
        name: json["subdistrict_name"],
        districtId: json["district_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subdistrict_code": code,
        "subdistrict_name": name,
        "district_id": districtId,
      };

  factory SubDistrictsModel.fromMap(Map<String, dynamic> map) {
    return SubDistrictsModel(
      id: map['id'] as int? ?? 0,
      code: map['subdistrict_code'] as String?,
      name: map['subdistrict_name'] as String?,
      districtId: map['district_id'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subdistrict_code': code,
      'subdistrict_name': name,
      'district_id': districtId,
    };
  }

  @override
  String toString() {
    return 'SubDistrictsModel(id: $id, code: $code, name: $name, districtId: $districtId)';
  }
}
