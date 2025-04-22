import 'package:flutter/material.dart';
import '../Pages/detail_page.dart';
import '../constant_model/models.dart';


class ItemAll extends StatelessWidget {
  final NewProduct pros;
  const ItemAll({super.key,required this.pros});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(proData: pros)));
      },
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(pros.image),
                    )
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text(pros.name),
            SizedBox(height: 5,),
            Text("\$${pros.prices}",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),)
          ],
        ),
      ),
    );
  }
}
