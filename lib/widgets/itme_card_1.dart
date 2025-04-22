import 'package:flutter/material.dart';
import '../pages/detail_page.dart';
import '../constant_model/models.dart';


class ItemCard extends StatelessWidget {

  final NewProduct pro;
  const ItemCard({super.key,required this.pro});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(proData: pro)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width*0.41,
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
                      image: AssetImage(pro.image),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(pro.name),
              ),
             // SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${pro.prices}",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                    IconButton(onPressed: (){}, icon: Icon(Icons.add_shopping_cart, color: Colors.red,size: 18,))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
