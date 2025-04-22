import 'package:flutter/material.dart';
import '../pages/detail_page.dart';
import '../constant_model/models.dart';

class Popular extends StatelessWidget {
  final NewProduct pop;
  const Popular({super.key, required this.pop});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailPage(proData: pop)),
        );
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
              "\$${pop.prices}",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
