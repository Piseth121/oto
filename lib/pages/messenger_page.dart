import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otokhi/pages/login_page.dart';
import '../constant_model/new_product.dart';
import '../widgets/chat.dart';
import '../widgets/itme_card_1.dart';
import '../widgets/notifications.dart';

class Messenger extends StatefulWidget {
  const Messenger({super.key});

  @override
  State<Messenger> createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messenger',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()));
                    }, icon: Icon(Icons.chat),),
                    Text('Chats'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                        }, icon: Icon(Icons.notifications_none)),
                    Text('Notifications'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: () {
                      Get.to(() => LoginPage());
                    }, icon: Icon(Icons.power_input)),
                    Text('other'),
                  ],
                ),
              ],
            ),
          ),
          //Divider(),
          buildText(),
          _buildRecommended(),
        ],
      ),
    );
  }

  Widget buildText() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Welcome to Messenger,',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Where communication is ;',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.task_alt),
              SizedBox(
                width: 5,
              ),
              Text(
                'Efficient',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Contact suppliers directly by tapping "Chat now" on product details page',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.task_alt),
              SizedBox(
                width: 5,
              ),
              Text(
                'Secure',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Communicate and pay on PIISIIT.SHOP to enjoy purchase protection',
            style: TextStyle(fontSize: 14),
          ),
          Divider(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Recommended for you',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommended(){
    return  Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              childAspectRatio: 0.70,
              crossAxisSpacing: 5),
          itemBuilder: (context, index) => ItemCard(pro: products[index])),
    );

  }
}
