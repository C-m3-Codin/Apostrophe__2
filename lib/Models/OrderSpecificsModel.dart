// To parse this JSON data, do
//
//     final orderSpecifics = orderSpecificsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderSpecifics orderSpecificsFromJson(String str) =>
    OrderSpecifics.fromJson(json.decode(str));

String orderSpecificsToJson(OrderSpecifics data) => json.encode(data.toJson());

class OrderSpecifics {
  OrderSpecifics({
    required this.data,
  });

  Data data;

  factory OrderSpecifics.fromJson(Map<String, dynamic> json) => OrderSpecifics(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.channelId,
    required this.channelName,
    required this.baseChannelCode,
    required this.isInternational,
    required this.channelOrderId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerAddress2,
    required this.customerCity,
    required this.customerState,
    required this.customerPincode,
    required this.customerCountry,
    required this.pickupCode,
    required this.pickupLocation,
    required this.pickupLocationId,
    required this.currency,
    required this.countryCode,
    required this.exchangeRateUsd,
    required this.exchangeRateInr,
    required this.stateCode,
    required this.paymentStatus,
    required this.deliveryCode,
    required this.total,
    required this.totalInr,
    required this.totalUsd,
    required this.netTotal,
    required this.otherCharges,
    required this.otherDiscounts,
    required this.giftwrapCharges,
    required this.expedited,
    required this.sla,
    required this.cod,
    required this.discount,
    required this.tax,
    required this.status,
    required this.subStatus,
    required this.statusCode,
    required this.paymentMethod,
    required this.purposeOfShipment,
    required this.channelCreatedAt,
    required this.createdAt,
    required this.orderDate,
    required this.updatedAt,
    required this.products,
    required this.shipments,
    required this.awbData,
    required this.returnPickupData,
    required this.companyLogo,
    required this.allowReturn,
    required this.isReturn,
    required this.isIncomplete,
    // required this.errors,
    required this.trackingUrl,
    required this.paymentCode,
    required this.billingCity,
    required this.billingName,
    required this.billingEmail,
    required this.billingPhone,
    required this.billingStateName,
    required this.billingAddress,
    required this.billingCountryName,
    required this.billingPincode,
    required this.billingAddress2,
    required this.billingMobileCountryCode,
    required this.billingStateId,
    required this.billingCountryId,
    required this.resellerName,
    required this.shippingIsBilling,
    required this.ewayBillNumber,
    required this.companyName,
    required this.shippingTitle,
  });

  int id;
  int channelId;
  String channelName;
  String baseChannelCode;
  int isInternational;
  String channelOrderId;
  String customerName;
  String customerEmail;
  String customerPhone;
  String customerAddress;
  String customerAddress2;
  String customerCity;
  String customerState;
  String customerPincode;
  String customerCountry;
  String pickupCode;
  String pickupLocation;
  int pickupLocationId;
  String currency;
  int countryCode;
  int exchangeRateUsd;
  int exchangeRateInr;
  int stateCode;
  String paymentStatus;
  String deliveryCode;
  String total;
  int totalInr;
  int totalUsd;
  String netTotal;
  String otherCharges;
  String otherDiscounts;
  String giftwrapCharges;
  int expedited;
  String sla;
  int cod;
  int discount;
  String tax;
  String status;
  dynamic subStatus;
  int statusCode;
  String paymentMethod;
  int purposeOfShipment;
  String channelCreatedAt;
  String createdAt;
  String orderDate;
  String updatedAt;
  List<Product> products;
  Shipments shipments;
  AwbData awbData;
  String returnPickupData;
  dynamic companyLogo;
  String allowReturn;
  String isReturn;
  String isIncomplete;
  // List<dynamic> errors;
  dynamic paymentCode;
  String billingCity;
  String billingName;
  String billingEmail;
  String billingPhone;
  String billingStateName;
  String billingAddress;
  String billingCountryName;
  String billingPincode;
  String billingAddress2;
  String billingMobileCountryCode;
  String billingStateId;
  String billingCountryId;
  String resellerName;
  int shippingIsBilling;
  String ewayBillNumber;
  dynamic companyName;
  String shippingTitle;
  String trackingUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        trackingUrl: json["others"]["order_status_url"] == null
            ? "N/A"
            : json["others"]["order_status_url"],
        channelId: json["channel_id"],
        channelName: json["channel_name"],
        baseChannelCode: json["base_channel_code"],
        isInternational: json["is_international"],
        channelOrderId: json["channel_order_id"],
        customerName: json["customer_name"],
        customerEmail: json["customer_email"],
        customerPhone: json["customer_phone"],
        customerAddress: json["customer_address"],
        customerAddress2: json["customer_address_2"],
        customerCity: json["customer_city"],
        customerState: json["customer_state"],
        customerPincode: json["customer_pincode"],
        customerCountry: json["customer_country"],
        pickupCode: json["pickup_code"],
        pickupLocation: json["pickup_location"],
        pickupLocationId: json["pickup_location_id"],
        currency: json["currency"],
        countryCode: json["country_code"],
        exchangeRateUsd: json["exchange_rate_usd"],
        exchangeRateInr: json["exchange_rate_inr"],
        stateCode: json["state_code"],
        paymentStatus: json["payment_status"],
        deliveryCode: json["delivery_code"],
        total: json["total"].toString(),
        totalInr: json["total_inr"],
        totalUsd: json["total_usd"],
        netTotal: json["net_total"],
        otherCharges: json["other_charges"].toString(),
        otherDiscounts: json["other_discounts"],
        giftwrapCharges: json["giftwrap_charges"],
        expedited: json["expedited"],
        sla: json["sla"],
        cod: json["cod"],
        discount: json["discount"],
        tax: json["tax"].toString(),
        status: json["status"],
        subStatus: json["sub_status"],
        statusCode: json["status_code"],
        paymentMethod: json["payment_method"],
        purposeOfShipment: json["purpose_of_shipment"],
        channelCreatedAt: json["channel_created_at"],
        createdAt: json["created_at"],
        orderDate: json["order_date"],
        updatedAt: json["updated_at"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        shipments: Shipments.fromJson(json["shipments"]),
        awbData: AwbData.fromJson(json["awb_data"]),
        returnPickupData: json["return_pickup_data"],
        companyLogo: json["company_logo"],
        allowReturn: json["allow_return"].toString(),
        isReturn: json["is_return"].toString(),
        isIncomplete: json["is_incomplete"].toString(),
        // errors: List<dynamic>.from(json["errors"].map((x) => x)),
        paymentCode: json["payment_code"],
        billingCity: json["billing_city"],
        billingName: json["billing_name"],
        billingEmail: json["billing_email"],
        billingPhone: json["billing_phone"],
        billingStateName: json["billing_state_name"],
        billingAddress: json["billing_address"],
        billingCountryName: json["billing_country_name"],
        billingPincode: json["billing_pincode"].toString(),
        billingAddress2: json["billing_address_2"],
        billingMobileCountryCode: json["billing_mobile_country_code"],
        billingStateId: json["billing_state_id"].toString(),
        billingCountryId: json["billing_country_id"].toString(),
        resellerName: json["reseller_name"],
        shippingIsBilling: json["shipping_is_billing"],
        ewayBillNumber: json["eway_bill_number"],
        companyName: json["company_name"],
        shippingTitle: json["shipping_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "channel_id": channelId,
        "channel_name": channelName,
        "base_channel_code": baseChannelCode,
        "is_international": isInternational,
        "channel_order_id": channelOrderId,
        "customer_name": customerName,
        "customer_email": customerEmail,
        "customer_phone": customerPhone,
        "customer_address": customerAddress,
        "customer_address_2": customerAddress2,
        "customer_city": customerCity,
        "customer_state": customerState,
        "customer_pincode": customerPincode,
        "customer_country": customerCountry,
        "pickup_code": pickupCode,
        "pickup_location": pickupLocation,
        "pickup_location_id": pickupLocationId,
        "currency": currency,
        "country_code": countryCode,
        "exchange_rate_usd": exchangeRateUsd,
        "exchange_rate_inr": exchangeRateInr,
        "state_code": stateCode,
        "payment_status": paymentStatus,
        "delivery_code": deliveryCode,
        "total": total,
        "total_inr": totalInr,
        "total_usd": totalUsd,
        "net_total": netTotal,
        "other_charges": otherCharges,
        "other_discounts": otherDiscounts,
        "giftwrap_charges": giftwrapCharges,
        "expedited": expedited,
        "sla": sla,
        "cod": cod,
        "discount": discount,
        "tax": tax,
        "status": status,
        "sub_status": subStatus,
        "status_code": statusCode,
        "payment_method": paymentMethod,
        "purpose_of_shipment": purposeOfShipment,
        "channel_created_at": channelCreatedAt,
        "created_at": createdAt,
        "order_date": orderDate,
        "updated_at": updatedAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "shipments": shipments.toJson(),
        "awb_data": awbData.toJson(),
        "return_pickup_data": returnPickupData,
        "company_logo": companyLogo,
        "allow_return": allowReturn,
        "is_return": isReturn,
        "is_incomplete": isIncomplete,
        // "errors": List<dynamic>.from(errors.map((x) => x)),
        "order_status_url": trackingUrl,
        "payment_code": paymentCode,
        "billing_city": billingCity,
        "billing_name": billingName,
        "billing_email": billingEmail,
        "billing_phone": billingPhone,
        "billing_state_name": billingStateName,
        "billing_address": billingAddress,
        "billing_country_name": billingCountryName,
        "billing_pincode": billingPincode,
        "billing_address_2": billingAddress2,
        "billing_mobile_country_code": billingMobileCountryCode,
        "billing_state_id": billingStateId,
        "billing_country_id": billingCountryId,
        "reseller_name": resellerName,
        "shipping_is_billing": shippingIsBilling,
        "eway_bill_number": ewayBillNumber,
        "company_name": companyName,
        "shipping_title": shippingTitle,
      };
}

class AwbData {
  AwbData({
    required this.awb,
    required this.appliedWeight,
    required this.chargedWeight,
    required this.billedWeight,
    required this.routingCode,
  });

  String awb;
  String appliedWeight;
  String chargedWeight;
  String billedWeight;
  String routingCode;

  factory AwbData.fromJson(Map<String, dynamic> json) => AwbData(
        awb: json["awb"],
        appliedWeight: json["applied_weight"].toString(),
        chargedWeight: json["charged_weight"].toString(),
        billedWeight: json["billed_weight"].toString(),
        routingCode: json["routing_code"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "awb": awb,
        "applied_weight": appliedWeight,
        "charged_weight": chargedWeight,
        "billed_weight": billedWeight,
        "routing_code": routingCode,
      };
}

class Product {
  Product({
    required this.id,
    required this.orderId,
    required this.name,
    required this.sku,
    required this.channelOrderProductId,
    required this.channelSku,
    required this.hsn,
    required this.model,
    required this.manufacturer,
    required this.brand,
    required this.color,
    required this.size,
    required this.customField,
    required this.customFieldValue,
    required this.customFieldValueString,
    required this.weight,
    required this.dimensions,
    required this.price,
    required this.cost,
    required this.mrp,
    required this.quantity,
    required this.tax,
    required this.status,
    required this.netTotal,
    required this.discount,
    required this.productOptions,
    required this.sellingPrice,
    required this.taxPercentage,
    required this.discountIncludingTax,
    required this.channelCategory,
  });

  String id;
  String orderId;
  String name;
  String sku;
  String channelOrderProductId;
  String channelSku;
  String hsn;
  dynamic model;
  dynamic manufacturer;
  dynamic brand;
  dynamic color;
  dynamic size;
  String customField;
  String customFieldValue;
  String customFieldValueString;
  String weight;
  String dimensions;
  String price;
  String cost;
  String mrp;
  String quantity;
  String tax;
  String status;
  String netTotal;
  String discount;
  List<dynamic> productOptions;
  String sellingPrice;
  String taxPercentage;
  String discountIncludingTax;
  String channelCategory;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"].toString().toString(),
        orderId: json["order_id"].toString(),
        name: json["name"].toString(),
        sku: json["sku"].toString(),
        channelOrderProductId: json["channel_order_product_id"].toString(),
        channelSku: json["channel_sku"].toString(),
        hsn: json["hsn"].toString(),
        model: json["model"].toString(),
        manufacturer: json["manufacturer"].toString(),
        brand: json["brand"].toString(),
        color: json["color"].toString(),
        size: json["size"].toString(),
        customField: json["custom_field"].toString(),
        customFieldValue: json["custom_field_value"].toString(),
        customFieldValueString: json["custom_field_value_string"].toString(),
        weight: json["weight"].toString().toString(),
        dimensions: json["dimensions"].toString(),
        price: json["price"].toString(),
        cost: json["cost"].toString(),
        mrp: json["mrp"].toString(),
        quantity: json["quantity"].toString(),
        tax: json["tax"].toString(),
        status: json["status"].toString(),
        netTotal: json["net_total"].toString(),
        discount: json["discount"].toString(),
        productOptions:
            List<dynamic>.from(json["product_options"].map((x) => x)),
        sellingPrice: json["selling_price"].toString(),
        taxPercentage: json["tax_percentage"].toString(),
        discountIncludingTax: json["discount_including_tax"].toString(),
        channelCategory: json["channel_category"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "name": name,
        "sku": sku,
        "channel_order_product_id": channelOrderProductId,
        "channel_sku": channelSku,
        "hsn": hsn,
        "model": model,
        "manufacturer": manufacturer,
        "brand": brand,
        "color": color,
        "size": size,
        "custom_field": customField,
        "custom_field_value": customFieldValue,
        "custom_field_value_string": customFieldValueString,
        "weight": weight,
        "dimensions": dimensions,
        "price": price,
        "cost": cost,
        "mrp": mrp,
        "quantity": quantity,
        "tax": tax,
        "status": status,
        "net_total": netTotal,
        "discount": discount,
        "product_options": List<dynamic>.from(productOptions.map((x) => x)),
        "selling_price": sellingPrice,
        "tax_percentage": taxPercentage,
        "discount_including_tax": discountIncludingTax,
        "channel_category": channelCategory,
      };
}

class Shipments {
  Shipments({
    required this.id,
    required this.orderId,
    @required this.orderProductId,
    required this.channelId,
    required this.code,
    required this.cost,
    @required this.awb,
    required this.codCharges,
    @required this.number,
    @required this.name,
    @required this.orderItemId,
    required this.weight,
    required this.volumetricWeight,
    required this.dimensions,
    required this.comment,
    required this.courier,
    required this.courierId,
    required this.manifestId,
    required this.status,
    required this.isdCode,
    required this.createdAt,
    required this.updatedAt,
    @required this.pod,
    required this.ewayBillNumber,
    @required this.ewayBillDate,
  });

  String id;
  String orderId;
  dynamic orderProductId;
  String channelId;
  String code;
  String cost;
  dynamic awb;
  String codCharges;
  dynamic number;
  dynamic name;
  dynamic orderItemId;
  String weight;
  String volumetricWeight;
  String dimensions;
  String comment;
  String courier;
  String courierId;
  String manifestId;
  String status;
  String isdCode;
  String createdAt;
  String updatedAt;
  dynamic pod;
  String ewayBillNumber;
  dynamic ewayBillDate;

  factory Shipments.fromJson(Map<String, dynamic> json) => Shipments(
        id: json["id"].toString(),
        orderId: json["order_id"].toString(),
        orderProductId: json["order_product_id"],
        channelId: json["channel_id"].toString(),
        code: json["code"].toString(),
        cost: json["cost"].toString(),
        awb: json["awb"],
        codCharges: json["cod_charges"].toString(),
        number: json["number"].toString(),
        name: json["name"].toString(),
        orderItemId: json["order_item_id"],
        weight: json["weight"].toString(),
        volumetricWeight: json["volumetric_weight"].toString(),
        dimensions: json["dimensions"],
        comment: json["comment"],
        courier: json["courier"],
        courierId: json["courier_id"].toString(),
        manifestId: json["manifest_id"].toString(),
        status: json["status"],
        isdCode: json["isd_code"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pod: json["pod"],
        ewayBillNumber: json["eway_bill_number"].toString(),
        ewayBillDate: json["eway_bill_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "order_product_id": orderProductId,
        "channel_id": channelId,
        "code": code,
        "cost": cost,
        "awb": awb,
        "cod_charges": codCharges,
        "number": number,
        "name": name,
        "order_item_id": orderItemId,
        "weight": weight,
        "volumetric_weight": volumetricWeight,
        "dimensions": dimensions,
        "comment": comment,
        "courier": courier,
        "courier_id": courierId,
        "manifest_id": manifestId,
        "status": status,
        "isd_code": isdCode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pod": pod,
        "eway_bill_number": ewayBillNumber,
        "eway_bill_date": ewayBillDate,
      };
}
