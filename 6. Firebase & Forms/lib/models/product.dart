import 'dart:convert';

class ProductModel {
  ProductModel({
    required this.available,
    required this.name,
    this.picture,
    required this.price,
  });

  String? id;
  String? name;
  double? price;
  String? picture;
  bool available;

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };

  // Removes the direct reference to the memmory pointer creating a similar obj
  ProductModel copy() {
    final copy = ProductModel(available: available, name: name, price: price);
    copy.id = id;
    copy.picture = picture;
    return copy;
  }
}
