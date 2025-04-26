class Review {
  final String name;
  final double rating;
  final String comment;
  final DateTime timestamp;

  Review({
    required this.name,
    required this.rating,
    required this.comment,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      name: json['name'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'rating': rating,
    'comment': comment,
    'timestamp': timestamp.toIso8601String(),
  };
}
