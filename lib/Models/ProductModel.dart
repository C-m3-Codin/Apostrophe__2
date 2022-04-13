// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.data,
    this.meta,
  });

  List<Datum> data;
  Meta? meta;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.sku,
    required this.hsn,
    required this.name,
    required this.description,
    required this.categoryCode,
    required this.categoryName,
    required this.categoryTaxCode,
    required this.image,
    required this.weight,
    required this.size,
    required this.costPrice,
    required this.mrp,
    required this.taxCode,
    required this.lowStock,
    required this.ean,
    required this.upc,
    required this.isbn,
    required this.createdAt,
    required this.updatedAt,
    required this.quantity,
    required this.color,
    required this.brand,
    required this.dimensions,
    required this.status,
    required this.type,
  });

  int id;
  String sku;
  String hsn;
  String name;
  String description;
  String categoryCode;
  String categoryName;
  String categoryTaxCode;
  String image;
  String weight;
  String size;
  String costPrice;
  String mrp;
  String taxCode;
  int lowStock;
  String ean;
  String upc;
  String isbn;
  String createdAt;
  String updatedAt;
  int quantity;
  String color;
  String brand;
  String dimensions;
  String status;
  String type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sku: json["sku"],
        hsn: json["hsn"],
        name: json["name"],
        description: json["description"],
        categoryCode: json["category_code"],
        categoryName: json["category_name"],
        categoryTaxCode: json["category_tax_code"],
        image: json["image"],
        weight: json["weight"],
        size: json["size"],
        costPrice: json["cost_price"],
        mrp: json["mrp"],
        taxCode: json["tax_code"].toString(),
        lowStock: json["low_stock"],
        ean: json["ean"],
        upc: json["upc"],
        isbn: json["isbn"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        quantity: json["quantity"],
        color: json["color"],
        brand: json["brand"],
        dimensions: json["dimensions"],
        status: json["status"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "hsn": hsn,
        "name": name,
        "description": description,
        "category_code": categoryCode,
        "category_name": categoryName,
        "category_tax_code": categoryTaxCode,
        "image": image,
        "weight": weight,
        "size": size,
        "cost_price": costPrice,
        "mrp": mrp,
        "tax_code": taxCode,
        "low_stock": lowStock,
        "ean": ean,
        "upc": upc,
        "isbn": isbn,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "quantity": quantity,
        "color": color,
        "brand": brand,
        "dimensions": dimensions,
        "status": status,
        "type": type,
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
