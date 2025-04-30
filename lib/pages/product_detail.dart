import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:otokhi/Pages/cart_page.dart';
import '../controllers/cart_controller.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/review_controller.dart';
import '../models/review_model.dart';
import '../widgets/chat.dart';
import '../widgets/favorite.dart';
import '../widgets/itme_card_1.dart';

class DetailPage extends StatefulWidget {
  final dynamic proData;

  DetailPage({required this.proData});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final CartController cartController = Get.find<CartController>();
  final FavoriteController favoriteController = Get.find<FavoriteController>(); // Assuming you have a FavoriteController ->
  final ReviewController reviewController = Get.put(ReviewController());
  final ProductController controller = Get.put(ProductController());

  late bool isFavorite;
  final RxBool showAllReviews = false.obs;

  void initState() {
    super.initState();
    isFavorite = favoriteController.isFavorite(widget.proData);
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
        title: Text(widget.proData.name, style: TextStyle(fontFamily: "battambang",fontSize: 18,fontWeight: FontWeight.bold)),
        actions: [
          Obx(() {
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () => Get.to(() => FavoriteListScreen()),
                ),
                if (favoriteController.favoriteItems.isNotEmpty)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${favoriteController.favoriteItems.length}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            );
          }),
          Obx(() {
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () => Get.to(() => CartPage()),
                ),
                if (cartController.cartItems.isNotEmpty)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cartController.cartItems.length}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: ListView(
        children: [
          _buildImage(),
          _buildProductInfo(),
          Divider(height: 10,color: Colors.black,),
          _buildRecommendProduct(),
          _buildReviewsSection(),
        ],
      ),
      bottomNavigationBar: _buildBottom(),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 300,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        color: Colors.grey[200],
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
          Row(
            children: [
              RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemBuilder:
                    (context, _) => const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  // Handle rating update
                },
              ),
              const SizedBox(width: 8),
              Text(
                '4.5/5',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.45),
              IconButton(
                onPressed: () {
                  setState(() {
                    favoriteController.toggleFavorite(widget.proData);
                    isFavorite = favoriteController.isFavorite(widget.proData);
                    Get.snackbar(
                      'Favorite',
                      isFavorite
                          ? 'Added to favorites'
                          : 'Removed from favorites',
                    );
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  size: 30,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
          Text("\$${widget.proData.price}", style: TextStyle(fontSize: 20, color: Colors.red)),
          SizedBox(height: 10),
          Text("Category: ${widget.proData.category}", style: TextStyle(fontSize: 16,fontFamily: "battambang")),
          SizedBox(height: 10),
          Text("In Stock: ${widget.proData.stockQty}", style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Divider(height: 10,color: Colors.black,),
          Text("Description :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Chat()),
                  );
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
                child: ElevatedButton.icon(
                  onPressed: () {
                    cartController.addToCart(widget.proData);
                    Get.to(()=> CartPage());
                    Get.snackbar("Added to Cart", "${widget.proData.name} has been added to your cart.",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.grey,
                        colorText: Colors.white);
                  },
                  icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                  label: Text("Add to Cart", style: TextStyle(fontSize: 15,color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Buy Now Button
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: ElevatedButton.icon(
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
                  icon: Icon(Icons.shopping_bag, color: Colors.white),
                  label: Text("Buy Now",style: TextStyle(fontSize: 15,color: Colors.white),),
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
            itemCount: controller.recommendeds.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemCard(pro: controller.recommendeds[index]);
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
        const Divider(height: 20,),
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
