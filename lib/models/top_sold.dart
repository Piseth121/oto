class TopSelling {
  final int id;
  final String code;
  final String name;
  final String? nameEn;
  final String uom;
  final double price;
  final String? description;
  final double stockQty;
  final String category;
  final int categoryId;
  final List<String> images;


  TopSelling({
    required this.id,
    required this.code,
    required this.name,
    this.nameEn,
    required this.uom,
    required this.price,
    this.description,
    required this.stockQty,
    required this.category,
    required this.categoryId,
    required this.images,
  });

  factory TopSelling.fromJson(Map<String, dynamic> json) {
    return TopSelling(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      nameEn: json['nameEn'],
      uom: json['uom'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      stockQty: (json['stockQty'] as num).toDouble(),
      category: json['category'],
      categoryId: json['categoryId'],
      images: json['images'] != null ? List<String>.from(json['images']) : [],
    );
  }
}
