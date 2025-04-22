
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}
List<String> items = [
  ''
];

String query = '';

class _SearchPageState extends State<SearchPage> {
  List<String> filteredItems = items
      .where((item) => item.toLowerCase().contains(query.toLowerCase()))
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: filteredItems.isEmpty
                  ? Center(child: Text('No results found'))
                  : Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.disabled_by_default,color: Colors.grey,),
                    title: Text('គ្រឿងប្រដាប់ជាង', style: TextStyle(fontFamily: "battambang",fontSize: 16),),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.disabled_by_default,color: Colors.grey,),
                    title: Text('ច្រវាក់និងកៅឡាក់', style: TextStyle(fontFamily: "battambang",fontSize: 16),),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.disabled_by_default,color: Colors.grey,),
                    title: Text('ម៉ូទ័រយោង', style: TextStyle(fontFamily: "battambang",fontSize: 16),),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.disabled_by_default,color: Colors.grey,),
                    title: Text('ខ្សែស្ទួច', style: TextStyle(fontFamily: "battambang",fontSize: 16),),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
