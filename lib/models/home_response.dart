
import 'package:otokhi/models/product_model.dart';

class HomeResponse {
  final List<Product> products;
  final List<Product> newProducts;
  final List<Product> topSolds;
  final List<Product> recommendeds;
  final Product? feature;

  HomeResponse({
    required this.products,
    required this.newProducts,
    required this.topSolds,
    required this.recommendeds,
    this.feature,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      products: (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
      newProducts: (json['newProducts'] as List).map((e) => Product.fromJson(e)).toList(),
      topSolds: (json['topSolds'] as List).map((e) => Product.fromJson(e)).toList(),
      recommendeds: (json['recommendeds'] as List).map((e) => Product.fromJson(e)).toList(),
      feature: json['feature'] != null ? Product.fromJson(json['feature']) : null,
    );
  }
}
