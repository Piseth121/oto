import 'package:flutter/material.dart';
import 'package:otokhi/constant_model/models.dart';

import '../Pages/detail_page.dart';



class ItemCard2 extends StatelessWidget {
  final Product product2;
  const ItemCard2({super.key,required this.product2});

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
                      image: AssetImage(product2.image),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(product2.name),
            ),
            // SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}


