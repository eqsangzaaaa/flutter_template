// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

List<ProductResponse> productResponseFromJson(String str) => List<ProductResponse>.from(json.decode(str).map((x) => ProductResponse.fromJson(x)));

String productResponseToJson(List<ProductResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductResponse {
    ProductResponse({
        this.id,
        this.name,
        this.price,
        this.image,
        this.createdOn,
        this.updatedOn,
    });

    int? id;
    String? name;
    double? price;
    String? image;
    DateTime? createdOn;
    DateTime? updatedOn;

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        id: json["id"],
        name: json["name"],
        price: json["price"].toDouble(),
        image: json["image"],
        createdOn: DateTime.parse(json["createdOn"]),
        updatedOn: DateTime.parse(json["updatedOn"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "createdOn": createdOn?.toIso8601String(),
        "updatedOn": updatedOn?.toIso8601String(),
    };
}
