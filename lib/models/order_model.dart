class Order {
  final String id;
  final String title;
  final double total;
  final String status;
  final List<String> images;

  Order({
    required this.id,
    required this.title,
    required this.total,
    required this.status,
    required this.images,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      title: json['title'],
      total: json['total'],
      status: json['status'],
      images: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'total': total,
    'status': status,
    'images': images,
  };
}
