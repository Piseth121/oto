import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constant_model/new_product.dart';
import '../controllers/review_controller.dart';
import '../models/review_model.dart';
import '../widgets/itme_card_1.dart';

class DetailPageP extends StatefulWidget {
  final dynamic proData;

  DetailPageP({required this.proData});

  @override
  State<DetailPageP> createState() => _DetailPagePState();
}

class _DetailPagePState extends State<DetailPageP> {
  final ReviewController reviewController = Get.put(ReviewController());
  final RxBool showAllReviews = false.obs;

  @override
  void initState() {
    super.initState();
  }

  void showReviewDialog() {
    final nameController = TextEditingController();
    final commentController = TextEditingController();
    double rating = 3.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Write a Review'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Your Name'),
                ),
                SizedBox(height: 10),
                Text('Your Rating'),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  itemBuilder:
                      (context, _) => Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (value) {
                    rating = value;
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: InputDecoration(labelText: 'Your Comment'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Submit', style: TextStyle(color: Colors.white)),
              onPressed: () {
                final review = Review(
                  name: nameController.text.trim(),
                  rating: rating,
                  comment: commentController.text.trim(),
                  timestamp: DateTime.now(),
                );
                reviewController.addReview(review);
                Navigator.of(context).pop();
                Get.snackbar('Review Added', 'Thanks for your feedback!');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.proData.name, style: TextStyle(fontFamily: "battambang")),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart page if available
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildImage(),
          _buildProductInfo(),
          Divider(height: 20, color: Colors.black),
          _buildRecommendProduct(),
          Divider(height: 20, color: Colors.black),
          _buildReviewsSection(),
        ],
      ),
      bottomNavigationBar: _buildBottom(),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 300,
      child: PageView.builder(
        itemCount: widget.proData.images.length,
        itemBuilder: (context, index) {
          return Image.network(
            widget.proData.images[index],
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (_, __, ___) => Image.asset('assets/images/no_image.png'),
          );
        },
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.proData.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: "battambang")),
          SizedBox(height: 10),
          Text("\$${widget.proData.price}", style: TextStyle(fontSize: 24, color: Colors.red)),
          SizedBox(height: 10),
          Text("Category: ${widget.proData.category}", style: TextStyle(fontSize: 16,fontFamily: "battambang"), ),
          SizedBox(height: 10),
          Text("In Stock: ${widget.proData.stockQty}", style: TextStyle(fontSize: 16)),
          Divider(height: 20, color: Colors.black),
          Text("Description:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Divider(),
          Text(widget.proData.description ?? "No description available", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                onPressed: () {

                },
                icon: Icon(
                  Icons.messenger_outline,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 20),
            // Add to Cart Button
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Add to cart logic
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Buy Now Button
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Add to cart logic
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendProduct() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended Product',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemCard(pro: products[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Reviews",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: showReviewDialog,
                  icon: Icon(Icons.rate_review, color: Colors.blue),
                  label: Text("Write Review"),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          final reviews = reviewController.reviews;
          final visibleReviews =
          showAllReviews.value ? reviews : reviews.take(5).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...visibleReviews.map(
                    (review) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                review.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat(
                                  'yyyy-MM-dd || HH:mm',
                                ).format(review.timestamp),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          RatingBarIndicator(
                            rating: review.rating,
                            itemBuilder:
                                (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                            itemCount: 5,
                            itemSize: 20.0,
                          ),
                          Text(review.comment),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              if (reviews.length > 5)
                Center(
                  child: TextButton(
                    onPressed:
                        () => showAllReviews.value = !showAllReviews.value,
                    child: Text(showAllReviews.value ? 'See Less' : 'See More'),
                  ),
                ),
              const Divider(),
            ],
          );
        }),
      ],
    );
  }
}
