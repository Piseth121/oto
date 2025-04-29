
import 'package:flutter/material.dart';
import 'package:otokhi/constant_model/top_selling.dart';
import 'itme_card_1.dart';

class GearedBeamTrolley extends StatefulWidget {
  const GearedBeamTrolley({super.key});

  @override
  State<GearedBeamTrolley> createState() => _GearedBeamTrolleyState();
}

class _GearedBeamTrolleyState extends State<GearedBeamTrolley> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ច្រវាក់ និងកៅឡាក់',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontFamily: "battambang"),),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(padding: const EdgeInsets.all(10),
          child: GridView.builder(
              itemCount: topselling.length,
              shrinkWrap: true,
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.70,
              ),
              itemBuilder: (context, index) => ItemCard(pro: topselling[index],)),
        ),
      ),
    );
  }
}
