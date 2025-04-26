
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
  final Set<String> _loadedImages = {};

  @override
  Widget build(BuildContext context) {
    void _jumpToSlide(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 250.0,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        autoPlayInterval: Duration(seconds: 6),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      items: imagePaths.map((path) {
        return Builder(
          builder: (BuildContext context) {
            return FutureBuilder(
              future: _loadImage(context, path),
              builder: (context, snapshot) {
                final isLoaded = _loadedImages.contains(path);
                return Stack(
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: isLoaded
                              ? Image.asset(path, fit: BoxFit.cover)
                              : Container(
                            color: Colors.grey[300],
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                    ),
                    if (!isLoaded)
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('Loading image...'),
                      ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
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
                    ),
                  ],
                );
              },
            );
          },
        );
      }).toList(),
    );
  }

  Future<void> _loadImage(BuildContext context, String path) async {
    if (!_loadedImages.contains(path)) {
      await precacheImage(AssetImage(path), context);
      _loadedImages.add(path);
      if (mounted) setState(() {});
    }
  }
}





