import 'dart:convert';

Product productModelFromJson(String str) => Product.fromJson(json.decode(str));

String productModelToJson(Product product) => json.encode(product.toJson());

class Product {
  String id;
  String title;
  double price;
  bool available;
  String photo;

  Product({
    this.id,
    this.title = '',
    this.price = 0.0,
    this.available = true,
    this.photo,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        available: json["available"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "available": available,
        "photo": photo,
      };
}
