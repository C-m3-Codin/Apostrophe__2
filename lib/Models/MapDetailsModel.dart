// To parse this JSON data, do
//
//     final mapTrack = mapTrackFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MapTrack mapTrackFromJson(String str) => MapTrack.fromJson(json.decode(str));

String mapTrackToJson(MapTrack data) => json.encode(data.toJson());

class MapTrack {
  MapTrack({
    required this.data,
  });

  List<Datum> data;

  factory MapTrack.fromJson(Map<String, dynamic> json) => MapTrack(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.latitude,
    required this.longitude,
    required this.label,
    required this.name,
    required this.type,
    // required this.number,
    required this.street,
    required this.postalCode,
    required this.confidence,
    required this.region,
    required this.regionCode,
    required this.administrativeArea,
    required this.neighbourhood,
    required this.country,
    required this.countryCode,
    required this.mapUrl,
  });

  double latitude;
  double longitude;
  String label;
  String name;
  String type;
  // String number;
  String street;
  String postalCode;
  String confidence;
  String region;
  String regionCode;
  dynamic administrativeArea;
  String neighbourhood;
  String country;
  String countryCode;
  String mapUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        label: json["label"],
        name: json["name"],
        type: json["type"],
        // number: json["number"],
        street: json["street"] ?? "null",
        postalCode: json["postal_code"] ?? "null",
        confidence: json["confidence"].toString(),
        region: json["region"] ?? "null",
        regionCode: json["region_code"],
        administrativeArea: json["administrative_area"] ?? "null",
        neighbourhood: json["neighbourhood"] ?? "null",
        country: json["country"] ?? "null",
        countryCode: json["country_code"] ?? "null",
        mapUrl: json["map_url"] ?? "null",
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "label": label,
        "name": name,
        "type": type,
        // "number": number,
        "street": street,
        "postal_code": postalCode,
        "confidence": confidence,
        "region": region,
        "region_code": regionCode,
        "administrative_area": administrativeArea,
        "neighbourhood": neighbourhood,
        "country": country,
        "country_code": countryCode,
        "map_url": mapUrl,
      };
}
