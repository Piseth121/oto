import 'package:flutter/material.dart';
import '../Pages/product_detail.dart';
import '../models/product_model.dart';


class ItemCardCircle extends StatelessWidget {
  final Product product2;
  const ItemCardCircle({super.key,required this.product2});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(proData: product2)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(100),
                  shape: BoxShape.circle,
                    image: DecorationImage(
                      image: product2.images.isEmpty ? AssetImage('assets/images/no_image.png') : NetworkImage(product2.images[0]) as ImageProvider,
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(product2.name,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "battambang")),
            ),
            // SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}


