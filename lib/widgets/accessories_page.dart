
import 'package:flutter/material.dart';

import '../constant_model/catigory.dart';
import 'itme_card_1.dart';

class AccessoriesPage extends StatefulWidget {
  const AccessoriesPage({super.key});

  @override
  State<AccessoriesPage> createState() => _AccessoriesPageState();
}

class _AccessoriesPageState extends State<AccessoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("គ្រឿងប្រដាប់ជាង",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "battambang"),),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: catigory.length,
            primary: false,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) => ItemCard(pro: catigory[index]),
          ),
        ),
      ),
    );
  }
}
