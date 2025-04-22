import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {

  final DateTime now = DateTime.now();
  final DateTime customDate = DateTime(2020, 7, 28, 10, 0);

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  final List<Map<String, String>> notifications = [
    {
      'title': 'Your email has been change to the new email',
      'date': '28 Jul 2020, 10:00',
      'boldWord': 'email'
    },
    {
      'title': 'Your password has been successfully changed',
      'date': '28 Jul 2020, 10:00',
      'boldWord': 'password'
    },
    {
      'title': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam eu massa in tempus. Etiam vitae sodales est.',
      'date': '28 Jul 2020, 10:00'
    },
    {
      'title': 'Curabitur finibus euismod neque eget placerat. Donec tincidunt felis eget blandit dictum.',
      'date': '28 Jul 2020, 10:00'
    },
    {
      'title': 'Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis lacinia dui lacus, in pretium est fringilla a.',
      'date': '28 Jul 2020, 10:00'
    },
    {
      'title': 'Suspendisse tempor urna tellus, vitae tristique mauris tincidunt sed.',
      'date': '28 Jul 2020, 10:00'
    },
    {
      'title': 'Quisque finibus maximus nunc vitae pretium. Nullam lacinia blandit orci, finibus dictum justo.',
      'date': '28 Jul 2020, 10:00'
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: item.containsKey('boldWord')
                      ? _buildBoldText(item['title']!, item['boldWord']!)
                      : [TextSpan(text: item['title'])],
                ),
              ),
              SizedBox(height: 5),
              Text(formatDate(now)),
            ],
          );
        },
      ),
    );
  }

  List<TextSpan> _buildBoldText(String fullText, String boldWord) {
    final split = fullText.split(boldWord);
    return [
      TextSpan(text: split[0]),
      TextSpan(text: boldWord, style: TextStyle(fontWeight: FontWeight.bold)),
      if (split.length > 1) TextSpan(text: split[1]),
    ];
  }
}