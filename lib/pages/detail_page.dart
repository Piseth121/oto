import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' show RatingBar;
import '../../constant_model/models.dart';
import '../../constant_model/new_product.dart';
import '../../widgets/chat.dart';
import '../../widgets/itme_card_1.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/favotite_controller.dart';
import 'cart_page.dart';


class DetailPage extends StatefulWidget {
  final NewProduct proData;

  const DetailPage({super.key,required this.proData,});


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = favoriteController.isFavorite(widget.proData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          widget.proData.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      //backgroundColor: Colors.blue,
    ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 10,),
            _buildImage(),
            _buildInfo(),
            _buildRecommendProduct(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottom(),
    );
  }

  Widget _buildImage(){
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 350,
          child: Image.asset(widget.proData.image, fit: BoxFit.cover,),
        )
      ],
    );
  }

  Widget _buildInfo(){
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.proData.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // Handle rating update
                },
              ),
              const SizedBox(width: 8),
              Text(
                '4.5/5',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.45,),
              IconButton(
                onPressed: () {
                  setState(() {
                    favoriteController.toggleFavorite(widget.proData);
                    isFavorite = favoriteController.isFavorite(widget.proData);
                    Get.snackbar('Favorite', isFavorite ? 'Added to favorites' : 'Removed from favorites');
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  size: 30,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              )

            ],
          ),
          SizedBox(height: 10,),
          // Product Price
          Text(
            '\$${widget.proData.prices.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          Divider(height: 20,color: Colors.black,),
          Text("Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
          Text(
            widget.proData.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 50,),
          Divider(),

        ],
      ),
    );
  }

  Widget _buildBottom(){
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()));
            }, icon: Icon(Icons.messenger_outline,size: 25,color: Colors.black,)),
            SizedBox(width: 20,),
            // Add to Cart Button
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add to cart logic
                      cartController.addToCart(widget.proData); // 🛒 Add product
                      Get.to(() => CartPage()); // Navigate to CartPage
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10), backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child:Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
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
                      padding: EdgeInsets.symmetric(vertical: 10), backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child:Text(
                      'Buy Now',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
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
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.70,
                  crossAxisSpacing: 5),
              itemBuilder: (context, index) => ItemCard(pro: products[index])),
        ),
      ],
    );
  }
}
