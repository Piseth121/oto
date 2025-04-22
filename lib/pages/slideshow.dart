
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class Slide_Show extends StatefulWidget {
  const Slide_Show({super.key});

  @override
  State<Slide_Show> createState() => _Slide_ShowState();
}

class _Slide_ShowState extends State<Slide_Show> {
  final List<String> imagePaths = [
    'assets/images/shop01.png',
    'assets/images/shop03.png',
    'assets/images/shop02.png',
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    void _jumpToSlide(int index) {
      setState(() {
        _currentIndex = index;
      });

    }
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            autoPlayInterval: Duration(seconds: 4),
          ),
          items: imagePaths.map((path) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(path, fit: BoxFit.cover),
                  ),
                );
              },
            );
          }).toList(),
        ),

        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imagePaths.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _jumpToSlide(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.redAccent
                      : Colors.grey[400],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  }




