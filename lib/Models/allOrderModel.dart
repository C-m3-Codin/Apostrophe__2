// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));

String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
  Orders({
    @required this.data,
    @required this.meta,
  });

  List<Datum>? data;
  Meta? meta;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Datum {
  Datum({
    @required this.id,
    @required this.channelId,
    @required this.channelName,
    @required this.baseChannelCode,
    @required this.channelOrderId,
    @required this.customerName,
    @required this.customerEmail,
    @required this.customerPhone,
    @required this.pickupLocation,
    @required this.paymentStatus,
    @required this.total,
    @required this.tax,
    @required this.sla,
    @required this.shippingMethod,
    @required this.expedited,
    @required this.status,
    @required this.statusCode,
    @required this.paymentMethod,
    @required this.isInternational,
    @required this.purposeOfShipment,
    @required this.channelCreatedAt,
    @required this.createdAt,
    required this.products,
    required this.shipments,
    required this.activities,
    @required this.allowReturn,
    @required this.isIncomplete,
    // required this.errors,
    @required this.showEscalationBtn,
    @required this.escalationStatus,
    required this.escalationHistory,
  });

  int? id;
  int? channelId;
  String? channelName;
  String? baseChannelCode;
  String? channelOrderId;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? pickupLocation;
  String? paymentStatus;
  String? total;
  String? tax;
  String? sla;
  String? shippingMethod;
  int? expedited;
  String? status;
  int? statusCode;
  String? paymentMethod;
  int? isInternational;
  int? purposeOfShipment;
  String? channelCreatedAt;
  String? createdAt;
  List<Product> products;
  List<Shipment> shipments;
  List<String> activities;
  int? allowReturn;
  int? isIncomplete;
  // List<dynamic> errors;
  int? showEscalationBtn;
  String? escalationStatus;
  List<dynamic> escalationHistory;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        channelId: json["channel_id"],
        channelName: json["channel_name"],
        baseChannelCode: json["base_channel_code"],
        channelOrderId: json["channel_order_id"],
        customerName: json["customer_name"],
        customerEmail: json["customer_email"],
        customerPhone: json["customer_phone"],
        pickupLocation: json["pickup_location"],
        paymentStatus: json["payment_status"],
        total: json["total"],
        tax: json["tax"],
        sla: json["sla"],
        shippingMethod: json["shipping_method"],
        expedited: json["expedited"],
        status: json["status"],
        statusCode: json["status_code"],
        paymentMethod: json["payment_method"],
        isInternational: json["is_international"],
        purposeOfShipment: json["purpose_of_shipment"],
        channelCreatedAt: json["channel_created_at"],
        createdAt: json["created_at"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        shipments: List<Shipment>.from(
            json["shipments"].map((x) => Shipment.fromJson(x))),
        activities: List<String>.from(json["activities"].map((x) => x)),
        allowReturn: json["allow_return"],
        isIncomplete: json["is_incomplete"],
        // errors: List<dynamic>.from(json["errors"].map((x) => x)),
        showEscalationBtn: json["show_escalation_btn"],
        escalationStatus: json["escalation_status"],
        escalationHistory:
            List<dynamic>.from(json["escalation_history"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "channel_id": channelId,
        "channel_name": channelName,
        "base_channel_code": baseChannelCode,
        "channel_order_id": channelOrderId,
        "customer_name": customerName,
        "customer_email": customerEmail,
        "customer_phone": customerPhone,
        "pickup_location": pickupLocation,
        "payment_status": paymentStatus,
        "total": total,
        "tax": tax,
        "sla": sla,
        "shipping_method": shippingMethod,
        "expedited": expedited,
        "status": status,
        "status_code": statusCode,
        "payment_method": paymentMethod,
        "is_international": isInternational,
        "purpose_of_shipment": purposeOfShipment,
        "channel_created_at": channelCreatedAt,
        "created_at": createdAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "shipments": List<dynamic>.from(shipments.map((x) => x.toJson())),
        "activities": List<dynamic>.from(activities.map((x) => x)),
        "allow_return": allowReturn,
        "is_incomplete": isIncomplete,
        // "errors": List<dynamic>.from(errors.map((x) => x)),
        "show_escalation_btn": showEscalationBtn,
        "escalation_status": escalationStatus,
        "escalation_history":
            List<dynamic>.from(escalationHistory.map((x) => x)),
      };
}

class Product {
  Product({
    @required this.id,
    @required this.channelOrderProductId,
    @required this.name,
    @required this.channelSku,
    @required this.quantity,
    @required this.productId,
    @required this.available,
    @required this.status,
    @required this.hsn,
  });

  int? id;
  String? channelOrderProductId;
  String? name;
  String? channelSku;
  int? quantity;
  int? productId;
  int? available;
  String? status;
  String? hsn;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        channelOrderProductId: json["channel_order_product_id"],
        name: json["name"],
        channelSku: json["channel_sku"],
        quantity: json["quantity"],
        productId: json["product_id"],
        available: json["available"],
        status: json["status"],
        hsn: json["hsn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "channel_order_product_id": channelOrderProductId,
        "name": name,
        "channel_sku": channelSku,
        "quantity": quantity,
        "product_id": productId,
        "available": available,
        "status": status,
        "hsn": hsn,
      };
}

class Shipment {
  Shipment({
    @required this.id,
    @required this.isdCode,
    @required this.courier,
    @required this.weight,
    @required this.dimensions,
    @required this.pickupScheduledDate,
    @required this.pickupTokenNumber,
    @required this.awb,
    @required this.returnAwb,
    @required this.volumetricWeight,
    @required this.pod,
    @required this.etd,
    @required this.rtoDeliveredDate,
    @required this.deliveredDate,
    @required this.etdEscalationBtn,
  });

  int? id;
  String? isdCode;
  String? courier;
  String? weight;
  String? dimensions;
  dynamic? pickupScheduledDate;
  dynamic? pickupTokenNumber;
  String? awb;
  String? returnAwb;
  String? volumetricWeight;
  dynamic? pod;
  String? etd;
  String? rtoDeliveredDate;
  dynamic? deliveredDate;
  bool? etdEscalationBtn;

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        id: json["id"],
        isdCode: json["isd_code"],
        courier: json["courier"],
        weight: json["weight"].toString(),
        dimensions: json["dimensions"],
        pickupScheduledDate: json["pickup_scheduled_date"],
        pickupTokenNumber: json["pickup_token_number"],
        awb: json["awb"],
        returnAwb: json["return_awb"],
        volumetricWeight: json["volumetric_weight"].toString(),
        pod: json["pod"],
        etd: json["etd"],
        rtoDeliveredDate: json["rto_delivered_date"],
        deliveredDate: json["delivered_date"],
        etdEscalationBtn: json["etd_escalation_btn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isd_code": isdCode,
        "courier": courier,
        "weight": weight,
        "dimensions": dimensions,
        "pickup_scheduled_date": pickupScheduledDate,
        "pickup_token_number": pickupTokenNumber,
        "awb": awb,
        "return_awb": returnAwb,
        "volumetric_weight": volumetricWeight,
        "pod": pod,
        "etd": etd,
        "rto_delivered_date": rtoDeliveredDate,
        "delivered_date": deliveredDate,
        "etd_escalation_btn": etdEscalationBtn,
      };
}

class Meta {
  Meta({
    @required this.pagination,
  });

  Pagination? pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
      };
}

class Pagination {
  Pagination({
    @required this.total,
    @required this.count,
    @required this.perPage,
    @required this.currentPage,
    @required this.totalPages,
    @required this.links,
  });

  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;
  Links? links;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        "links": links?.toJson(),
      };
}

class Links {
  Links();

  factory Links.fromJson(Map<String, dynamic> json) => Links();

  Map<String, dynamic> toJson() => {};
}
