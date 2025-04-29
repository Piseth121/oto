import 'package:flutter/material.dart';
import 'package:otokhi/constant_model/models.dart';
import '../Pages/detail_page.dart';
class Popular extends StatelessWidget {
  final Product pop;
  const Popular({super.key, required this.pop});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailPage(proData: pop)));
      },
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: AssetImage(pop.image)),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(pop.name),
            SizedBox(height: 5),
            Text(
              "\$${pop.prices.toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
