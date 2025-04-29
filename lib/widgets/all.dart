import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Pages/cart_page.dart';
import '../Pages/detail_page.dart';
import '../constant_model/models.dart';
import '../controllers/cart_controller.dart';


class ItemAll extends StatelessWidget {
  final Product pros;
  ItemAll({super.key,required this.pros});
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(proData: pros,)));
      },
      child: Container(
        width: 150,
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(pros.image),fit: BoxFit.cover,
                      )
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text(pros.name),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${pros.prices}",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                  IconButton(
                    onPressed: () {
                      cartController.addToCart(pros); // 🛒 Add product
                      print("Added to Cart: ${pros.name}");
                      Get.to(CartPage());;
                    },
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
