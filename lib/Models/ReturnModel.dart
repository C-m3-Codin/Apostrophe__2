// To parse this JSON data, do
//
//     final return = returnFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Return returnFromJson(String str) => Return.fromJson(json.decode(str));

String returnToJson(Return data) => json.encode(data.toJson());

class Return {
  Return({
    required this.data,
    required this.meta,
  });

  List<Datum> data;
  Meta meta;

  factory Return.fromJson(Map<String, dynamic> json) => Return(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.channelId,
    required this.channelName,
    required this.baseChannelCode,
    required this.channelOrderId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerPincode,
    required this.pickupCode,
    required this.pickupLocation,
    required this.paymentStatus,
    required this.total,
    required this.expedited,
    required this.sla,
    required this.shippingMethod,
    required this.status,
    required this.statusCode,
    required this.paymentMethod,
    required this.isInternational,
    required this.purposeOfShipment,
    required this.channelCreatedAt,
    required this.createdAt,
    required this.products,
    required this.deliveryCode,
    required this.cod,
    required this.shipmentId,
    required this.inQueue,
    required this.shipments,
  });

  int id;
  int channelId;
  String channelName;
  String baseChannelCode;
  String channelOrderId;
  String customerName;
  String customerEmail;
  String customerPhone;
  String customerPincode;
  String pickupCode;
  String pickupLocation;
  String paymentStatus;
  String total;
  int expedited;
  String sla;
  String shippingMethod;
  String status;
  int statusCode;
  String paymentMethod;
  int isInternational;
  int purposeOfShipment;
  String channelCreatedAt;
  String createdAt;
  List<Product> products;
  String deliveryCode;
  int cod;
  int shipmentId;
  int inQueue;
  List<Shipment> shipments;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        channelId: json["channel_id"],
        channelName: json["channel_name"],
        baseChannelCode: json["base_channel_code"],
        channelOrderId: json["channel_order_id"],
        customerName: json["customer_name"],
        customerEmail: json["customer_email"],
        customerPhone: json["customer_phone"],
        customerPincode: json["customer_pincode"],
        pickupCode: json["pickup_code"],
        pickupLocation: json["pickup_location"],
        paymentStatus: json["payment_status"],
        total: json["total"],
        expedited: json["expedited"],
        sla: json["sla"],
        shippingMethod: json["shipping_method"],
        status: json["status"],
        statusCode: json["status_code"],
        paymentMethod: json["payment_method"],
        isInternational: json["is_international"],
        purposeOfShipment: json["purpose_of_shipment"],
        channelCreatedAt: json["channel_created_at"],
        createdAt: json["created_at"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        deliveryCode: json["delivery_code"],
        cod: json["cod"],
        shipmentId: json["shipment_id"],
        inQueue: json["in_queue"],
        shipments: List<Shipment>.from(
            json["shipments"].map((x) => Shipment.fromJson(x))),
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
        "customer_pincode": customerPincode,
        "pickup_code": pickupCode,
        "pickup_location": pickupLocation,
        "payment_status": paymentStatus,
        "total": total,
        "expedited": expedited,
        "sla": sla,
        "shipping_method": shippingMethod,
        "status": status,
        "status_code": statusCode,
        "payment_method": paymentMethod,
        "is_international": isInternational,
        "purpose_of_shipment": purposeOfShipment,
        "channel_created_at": channelCreatedAt,
        "created_at": createdAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "delivery_code": deliveryCode,
        "cod": cod,
        "shipment_id": shipmentId,
        "in_queue": inQueue,
        "shipments": List<dynamic>.from(shipments.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.channelSku,
    required this.channelOrderProductId,
    required this.quantity,
    required this.productId,
    required this.sku,
    required this.customField,
    required this.customFieldValue,
    required this.status,
    required this.hsn,
  });

  int id;
  String name;
  String channelSku;
  String channelOrderProductId;
  int quantity;
  int productId;
  String sku;
  String customField;
  String customFieldValue;
  String status;
  String hsn;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        channelSku: json["channel_sku"],
        channelOrderProductId: json["channel_order_product_id"],
        quantity: json["quantity"],
        productId: json["product_id"],
        sku: json["sku"],
        customField: json["custom_field"],
        customFieldValue: json["custom_field_value"],
        status: json["status"],
        hsn: json["hsn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "channel_sku": channelSku,
        "channel_order_product_id": channelOrderProductId,
        "quantity": quantity,
        "product_id": productId,
        "sku": sku,
        "custom_field": customField,
        "custom_field_value": customFieldValue,
        "status": status,
        "hsn": hsn,
      };
}

class Shipment {
  Shipment({
    required this.isdCode,
    required this.courier,
    required this.srCourierId,
    required this.weight,
    required this.length,
    required this.breadth,
    required this.height,
    required this.volumetricWeight,
    required this.awb,
  });

  String isdCode;
  String courier;
  String srCourierId;
  String weight;
  String length;
  String breadth;
  String height;
  double volumetricWeight;
  String awb;

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        isdCode: json["isd_code"],
        courier: json["courier"],
        srCourierId: json["sr_courier_id"],
        weight: json["weight"],
        length: json["length"],
        breadth: json["breadth"],
        height: json["height"],
        volumetricWeight: json["volumetric_weight"].toDouble(),
        awb: json["awb"],
      );

  Map<String, dynamic> toJson() => {
        "isd_code": isdCode,
        "courier": courier,
        "sr_courier_id": srCourierId,
        "weight": weight,
        "length": length,
        "breadth": breadth,
        "height": height,
        "volumetric_weight": volumetricWeight,
        "awb": awb,
      };
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  Pagination({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.links,
  });

  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  Links links;

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
        "links": links.toJson(),
      };
}

class Links {
  Links({
    required this.next,
  });

  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
      };
}
