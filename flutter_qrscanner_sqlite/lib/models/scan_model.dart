import 'dart:convert';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  int? id;
  String? qrType;
  String value;

  ScanModel({
    this.id,
    this.qrType,
    required this.value,
  }) {
    if (this.value.contains('http')) {
      this.qrType = 'http';
    } else {
      this.qrType = 'geo';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        qrType: json["qr_type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qr_type": qrType,
        "value": value,
      };
}
