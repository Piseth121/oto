
class NewProduct {
  final int id;
  final String name;
  final String image;
  final double prices;
  final String description;
  final double productRating;
  int quantity;

  NewProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.prices,
    required this.description,
    required this.productRating,
    this.quantity = 1,
  });
  factory NewProduct.fromJson(Map<String, dynamic> json) {
    return NewProduct(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      prices: json['prices'],
      quantity: json['quantity'],
      description: json['description'],
      productRating: json['productRating'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'prices': prices,
    'quantity': quantity,
  };

}
