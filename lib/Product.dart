
class Product {
  String prodName = '';
  int prodPrice = 0;
  int prodQuantity = 0;

  Product(this.prodName, this.prodPrice, this.prodQuantity);

  Map<String, dynamic> toJson() {
    return {
      'prodName': prodName,
      'prodPrice': prodPrice,
      'prodQuantity': prodQuantity
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['prodName'] as String,
      json['prodPrice'] as int,
      json['prodQuantity'] as int
    );
  }
}
