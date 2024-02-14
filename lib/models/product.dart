class Product {
  String? code;
  String? name;
  int? quantity;
  String? productID;

  Product({
    this.code,
    this.name,
    this.quantity,
    this.productID,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        code: json["code"] ?? "",
        name: json["name"] ?? "",
        quantity: json["quantity"] ?? 0,
        productID: json["productID"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "quantity": quantity,
        "productID": productID,
      };
}
