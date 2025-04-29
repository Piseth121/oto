class NewProducts_pro {
  final int id;
  final String name;
  final String nameEn;
  final double price;
  final String description;
  final List<String> images;

  NewProducts_pro({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.price,
    required this.images,
    required this.description,
  });

  factory NewProducts_pro.fromJson(Map<String, dynamic> json) {
    return NewProducts_pro(
      id: json['id'],
      name: json['name'] ?? '',
      nameEn: json['nameEn'] ?? '',
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
      images: (json['images'] as List?)?.map<String>((img) => img.toString()).toList() ?? [],
    );
  }
}
