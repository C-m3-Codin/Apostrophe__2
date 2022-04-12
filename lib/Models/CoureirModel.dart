// To parse this JSON data, do
//
//     final couriers = couriersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Couriers couriersFromJson(String str) => Couriers.fromJson(json.decode(str));

String couriersToJson(Couriers data) => json.encode(data.toJson());

class Couriers {
  Couriers({
    required this.totalCourierCount,
    required this.serviceablePincodesCount,
    required this.pickupPincodesCount,
    required this.totalRtoCount,
    required this.totalOdaCount,
    required this.courierCount,
    required this.courierData,
  });

  int totalCourierCount;
  int serviceablePincodesCount;
  int pickupPincodesCount;
  int totalRtoCount;
  int totalOdaCount;
  int courierCount;
  List<CourierDatum> courierData;

  factory Couriers.fromJson(Map<String, dynamic> json) => Couriers(
        totalCourierCount: json["total_courier_count"],
        serviceablePincodesCount: json["serviceable_pincodes_count"],
        pickupPincodesCount: json["pickup_pincodes_count"],
        totalRtoCount: json["total_rto_count"],
        totalOdaCount: json["total_oda_count"],
        courierCount: json["courier_count"],
        courierData: List<CourierDatum>.from(
            json["courier_data"].map((x) => CourierDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_courier_count": totalCourierCount,
        "serviceable_pincodes_count": serviceablePincodesCount,
        "pickup_pincodes_count": pickupPincodesCount,
        "total_rto_count": totalRtoCount,
        "total_oda_count": totalOdaCount,
        "courier_count": courierCount,
        "courier_data": List<dynamic>.from(courierData.map((x) => x.toJson())),
      };
}

class CourierDatum {
  CourierDatum({
    required this.isOwnKeyCourier,
    required this.ownkeyCourierId,
    required this.id,
    required this.minWeight,
    required this.baseCourierId,
    required this.name,
    required this.useSrPostcodes,
    required this.type,
    required this.status,
    required this.courierType,
    required this.masterCompany,
    required this.serviceType,
    required this.mode,
    required this.image,
    required this.realtimeTracking,
    required this.deliveryBoyContact,
    required this.podAvailable,
    required this.callBeforeDelivery,
    required this.activatedDate,
    required this.newestDate,
    required this.shipmentCount,
    required this.isHyperlocal,
  });

  int isOwnKeyCourier;
  int ownkeyCourierId;
  int id;
  double minWeight;
  int baseCourierId;
  String name;
  int useSrPostcodes;
  int type;
  int status;
  int courierType;
  String masterCompany;
  int serviceType;
  int mode;
  Image image;
  RealtimeTracking? realtimeTracking;
  CallBeforeDelivery? deliveryBoyContact;
  PodAvailable? podAvailable;
  CallBeforeDelivery? callBeforeDelivery;
  DateTime? activatedDate;
  DateTime? newestDate;
  String shipmentCount;
  int isHyperlocal;

  factory CourierDatum.fromJson(Map<String, dynamic> json) => CourierDatum(
        isOwnKeyCourier: json["is_own_key_courier"],
        ownkeyCourierId: json["ownkey_courier_id"],
        id: json["id"],
        minWeight: json["min_weight"].toDouble(),
        baseCourierId: json["base_courier_id"],
        name: json["name"],
        useSrPostcodes: json["use_sr_postcodes"],
        type: json["type"],
        status: json["status"],
        courierType: json["courier_type"],
        masterCompany: json["master_company"],
        serviceType: json["service_type"],
        mode: json["mode"],
        image: Image.fromJson(json["image"]),
        realtimeTracking: realtimeTrackingValues.map[json["realtime_tracking"]],
        deliveryBoyContact:
            callBeforeDeliveryValues.map[json["delivery_boy_contact"]],
        podAvailable: podAvailableValues.map[json["pod_available"]],
        callBeforeDelivery:
            callBeforeDeliveryValues.map[json["call_before_delivery"]],
        activatedDate: DateTime.parse(json["activated_date"]),
        newestDate: json["newest_date"] == null
            ? null
            : DateTime.parse(json["newest_date"]),
        shipmentCount: json["shipment_count"],
        isHyperlocal: json["is_hyperlocal"],
      );

  Map<String, dynamic> toJson() => {
        "is_own_key_courier": isOwnKeyCourier,
        "ownkey_courier_id": ownkeyCourierId,
        "id": id,
        "min_weight": minWeight,
        "base_courier_id": baseCourierId,
        "name": name,
        "use_sr_postcodes": useSrPostcodes,
        "type": type,
        "status": status,
        "courier_type": courierType,
        "master_company": masterCompany,
        "service_type": serviceType,
        "mode": mode,
        "image": image.toJson(),
        "realtime_tracking": realtimeTrackingValues.reverse[realtimeTracking],
        "delivery_boy_contact":
            callBeforeDeliveryValues.reverse[deliveryBoyContact],
        "pod_available": podAvailableValues.reverse[podAvailable],
        "call_before_delivery":
            callBeforeDeliveryValues.reverse[callBeforeDelivery],
        "activated_date":
            "${activatedDate!.year.toString().padLeft(4, '0')}-${activatedDate!.month.toString().padLeft(2, '0')}-${activatedDate!.day.toString().padLeft(2, '0')}",
        "newest_date": newestDate == null
            ? null
            : "${newestDate!.year.toString().padLeft(4, '0')}-${newestDate!.month.toString().padLeft(2, '0')}-${newestDate!.day.toString().padLeft(2, '0')}",
        "shipment_count": shipmentCount,
        "is_hyperlocal": isHyperlocal,
      };
}

enum CallBeforeDelivery { AVAILABLE, NOT_AVAILABLE }

final callBeforeDeliveryValues = EnumValues({
  "Available": CallBeforeDelivery.AVAILABLE,
  "Not Available": CallBeforeDelivery.NOT_AVAILABLE
});

class Image {
  Image({
    required this.logo,
    required this.smallLogo,
    required this.emailLogoS3Path,
  });

  String logo;
  String smallLogo;
  String emailLogoS3Path;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        logo: json["logo"],
        smallLogo: json["small_logo"],
        emailLogoS3Path: json["email_logo_s3_path"],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
        "small_logo": smallLogo,
        "email_logo_s3_path": emailLogoS3Path,
      };
}

enum PodAvailable { INSTANT, ON_REQUEST }

final podAvailableValues = EnumValues(
    {"Instant": PodAvailable.INSTANT, "On Request": PodAvailable.ON_REQUEST});

enum RealtimeTracking { REAL_TIME, MIS }

final realtimeTrackingValues = EnumValues(
    {"MIS": RealtimeTracking.MIS, "Real Time": RealtimeTracking.REAL_TIME});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
