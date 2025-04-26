import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/review_model.dart';

class ReviewController extends GetxController {
  final storage = GetStorage();
  var reviews = <Review>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadReviews(); // Example static data; replace with real backend if needed
  }

  void loadReviews() {
    reviews.value = [
      Review(
        name: "Alice",
        rating: 4.5,
        comment: "Great product!",
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
      ),
      Review(
        name: "Bob",
        rating: 4.0,
        comment: "Worth the price.",
        timestamp: DateTime.now().subtract(Duration(days: 1)),
      ),
      Review(
        name: "Charlie",
        rating: 5.0,
        comment: "Loved it.",
        timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      ),
    ];
  }
  void saveReviews() {
    final encoded = jsonEncode(reviews.map((e) => e.toJson()).toList());
    storage.write('reviews', encoded);
  }

  void addReview(Review review) {
    reviews.add(review);// Assuming Review model has a save method
    saveReviews();
  }

}
