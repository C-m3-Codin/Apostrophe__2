// To parse this JSON data, do
//
//     final track = trackFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Track trackFromJson(String str) => Track.fromJson(json.decode(str));

String trackToJson(Track data) => json.encode(data.toJson());

class Track {
  Track({
    @required this.trackingData,
  });

  TrackingData? trackingData;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        trackingData: TrackingData.fromJson(json["tracking_data"]),
      );

  Map<String, dynamic> toJson() => {
        "tracking_data": trackingData?.toJson(),
      };
}

class TrackingData {
  TrackingData({
    @required this.trackStatus,
    @required this.shipmentStatus,
    required this.shipmentTrack,
    required this.shipmentTrackActivities,
    @required this.trackUrl,
    @required this.etd,
  });

  int? trackStatus;
  int? shipmentStatus;
  List<ShipmentTrack> shipmentTrack;
  List<ShipmentTrackActivity> shipmentTrackActivities;
  String? trackUrl;
  DateTime? etd;

  factory TrackingData.fromJson(Map<String, dynamic> json) => TrackingData(
        trackStatus: json["track_status"],
        shipmentStatus: json["shipment_status"],
        shipmentTrack: List<ShipmentTrack>.from(
            json["shipment_track"].map((x) => ShipmentTrack.fromJson(x))),
        shipmentTrackActivities: List<ShipmentTrackActivity>.from(
            json["shipment_track_activities"]
                .map((x) => ShipmentTrackActivity.fromJson(x))),
        trackUrl: json["track_url"],
        etd: DateTime.parse(json["etd"]),
      );

  Map<String, dynamic> toJson() => {
        "track_status": trackStatus,
        "shipment_status": shipmentStatus,
        "shipment_track":
            List<dynamic>.from(shipmentTrack.map((x) => x.toJson())),
        "shipment_track_activities":
            List<dynamic>.from(shipmentTrackActivities.map((x) => x.toJson())),
        "track_url": trackUrl,
        "etd": etd?.toIso8601String(),
      };
}

class ShipmentTrack {
  ShipmentTrack({
    @required this.id,
    @required this.awbCode,
    @required this.courierCompanyId,
    @required this.shipmentId,
    @required this.orderId,
    @required this.pickupDate,
    @required this.deliveredDate,
    @required this.weight,
    @required this.packages,
    @required this.currentStatus,
    @required this.deliveredTo,
    @required this.destination,
    @required this.consigneeName,
    @required this.origin,
    @required this.courierAgentDetails,
    @required this.edd,
  });

  int? id;
  String? awbCode;
  int? courierCompanyId;
  int? shipmentId;
  int? orderId;
  dynamic? pickupDate;
  dynamic? deliveredDate;
  String? weight;
  int? packages;
  String? currentStatus;
  String? deliveredTo;
  String? destination;
  String? consigneeName;
  String? origin;
  dynamic courierAgentDetails;
  DateTime? edd;

  factory ShipmentTrack.fromJson(Map<String, dynamic> json) => ShipmentTrack(
        id: json["id"],
        awbCode: json["awb_code"],
        courierCompanyId: json["courier_company_id"],
        shipmentId: json["shipment_id"],
        orderId: json["order_id"],
        pickupDate: json["pickup_date"],
        deliveredDate: json["delivered_date"],
        weight: json["weight"],
        packages: json["packages"],
        currentStatus: json["current_status"],
        deliveredTo: json["delivered_to"],
        destination: json["destination"],
        consigneeName: json["consignee_name"],
        origin: json["origin"],
        courierAgentDetails: json["courier_agent_details"],
        edd: DateTime.parse(json["edd"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "awb_code": awbCode,
        "courier_company_id": courierCompanyId,
        "shipment_id": shipmentId,
        "order_id": orderId,
        "pickup_date": pickupDate,
        "delivered_date": deliveredDate,
        "weight": weight,
        "packages": packages,
        "current_status": currentStatus,
        "delivered_to": deliveredTo,
        "destination": destination,
        "consignee_name": consigneeName,
        "origin": origin,
        "courier_agent_details": courierAgentDetails,
        "edd": edd?.toIso8601String(),
      };
}

class ShipmentTrackActivity {
  ShipmentTrackActivity({
    @required this.date,
    @required this.status,
    @required this.activity,
    @required this.location,
    @required this.srStatus,
  });

  DateTime? date;
  String? status;
  String? activity;
  String? location;
  String? srStatus;

  factory ShipmentTrackActivity.fromJson(Map<String, dynamic> json) =>
      ShipmentTrackActivity(
        date: DateTime.parse(json["date"]),
        status: json["status"],
        activity: json["activity"],
        location: json["location"],
        srStatus: json["sr-status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "status": status,
        "activity": activity,
        "location": location,
        "sr-status": srStatus,
      };
}
