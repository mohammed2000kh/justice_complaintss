// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

CommunitiesModel communityFromJson(String str) =>
    CommunitiesModel.fromJson(json.decode(str));

String communityToJson(CommunitiesModel data) => json.encode(data.toJson());

class CommunitiesModel {
  int id;
  String? code;
  String? name;
  int? subDistrictId;

  CommunitiesModel({
    required this.id,
    this.code,
    this.name,
    this.subDistrictId,
  });

  CommunitiesModel copyWith({
    int? idP,
    String? codeP,
    String? nameP,
    int? subdistrictIdP,
  }) =>
      CommunitiesModel(
        id: idP ?? id,
        code: codeP ?? code,
        name: nameP ?? name,
        subDistrictId: subdistrictIdP ?? subDistrictId,
      );

  factory CommunitiesModel.fromJson(Map<String, dynamic> json) =>
      CommunitiesModel(
        id: json["id"] ?? 0,
        code: json["community_code"],
        name: json["community_name"],
        subDistrictId: json["subdistrict_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "community_code": code,
        "community_name": name,
        "subdistrict_id": subDistrictId,
      };

  factory CommunitiesModel.fromMap(Map<String, dynamic> map) {
    return CommunitiesModel(
      id: map['id'] as int? ?? 0,
      code: map['community_code'] as String?,
      name: map['community_name'] as String?,
      subDistrictId: map['subdistrict_id'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'community_code': code,
      'community_name': name,
      'subdistrict_id': subDistrictId,
    };
  }

  @override
  String toString() {
    return 'CommunitiesModel(id: $id, code: $code, name: $name, subDistrictId: $subDistrictId)';
  }
}
