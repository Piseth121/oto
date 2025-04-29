import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otokhi/pages/cart_page.dart';
import '../constant_model/catigory.dart';
import '../constant_model/top_selling.dart';
import '../widgets/favorite.dart';
import '../widgets/itme_card_1.dart';
import 'home_product.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabBar get _tabBar => TabBar(
          isScrollable: true,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(
              child: Text('ផលិតផល', style: TextStyle(fontFamily: "battambang",fontSize: 16),),
            ),
            Tab(
              child: Text('គ្រឿងប្រដាប់ជាង', style: TextStyle(fontFamily: "battambang",fontSize: 16),),
            ),
            Tab(
              child: Text('ច្រវាក់និងកៅឡាក់', style: TextStyle(fontFamily: "battambang",fontSize: 16),),
            ),
            Tab(
              child: Text('ម៉ូទ័រយោង', style: TextStyle(fontFamily: "battambang",fontSize: 16),),
            ),
            Tab(
              child: Text('ជើងរ៉ៃមានច្រវ៉ាក់', style: TextStyle(fontFamily: "battambang",fontSize: 16),),
            ),
            Tab(
              child: Text('ខ្សែស្ទួច', style: TextStyle(fontFamily: "battambang",fontSize: 16),),
            )
          ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('OTOKHI' , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          backgroundColor: Colors.black,
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteListScreen()));
            }, icon: Icon(Icons.favorite ,color: Colors.white,)),
            IconButton(onPressed: () {
              Get.to(() => CartPage());
            }, icon: Icon(Icons.shopping_cart, color: Colors.white,)),
          ],
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: ColoredBox(
              color: Colors.white,
              child: _tabBar,
            ),
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(
        children: [
          HomeProduct(),
          accessories(),
          gearedBeamTrolley(),
          chain(),
          referenceMotor(),
          rope(),
        ]);
  }

  Widget accessories(){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("គ្រឿងប្រដាប់ជាង",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "battambang"),),
          ),
          Padding(
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
        ],
      ),
    );
  }

  Widget gearedBeamTrolley(){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: Text('ច្រវាក់ និងកៅឡាក់',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontFamily: "battambang"),),
          ),
          Padding(padding: const EdgeInsets.all(10),
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
                itemBuilder: (context, index) => ItemCard(pro: topselling[index])),
          )
        ],
      ),

    );
  }

  Widget chain(){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text('ម៉ូទ័រយោង', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "battambang"),),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: topselling.length,
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
                  childAspectRatio: 0.70,
            ), itemBuilder: (context, index)=> ItemCard(pro: topselling[index])),
          )
        ],
      ),
    );
  }

  Widget referenceMotor(){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text('ខ្សែស្ទួច', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "battambang"),),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: topselling.length,
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.70,
                ), itemBuilder: (context, index)=> ItemCard(pro: topselling[index])),
          )
        ],
      ),
    );
  }

  Widget rope(){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text('ម៉ូទ័រយោង', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "battambang"),),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: topselling.length,
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.70,
                ), itemBuilder: (context, index)=> ItemCard(pro: topselling[index])),
          )
        ],
      ),
    );
  }
}
