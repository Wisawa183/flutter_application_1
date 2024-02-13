import 'package:flutter/material.dart';

class ReadingScreen6 extends StatefulWidget {
  final List<dynamic> menuData;

  ReadingScreen6({Key? key, required this.menuData}) : super(key: key);

  @override
  _ReadingScreen6State createState() => _ReadingScreen6State();
}

class _ReadingScreen6State extends State<ReadingScreen6> {
  List<String> contentImages = [
    "assets/content6/content6_1.png",
    "assets/content6/content6_2.png",
    "assets/content6/content6_3.png",
    "assets/content6/content6_4.png",
    "assets/content6/content6_5.png",
    "assets/content6/content6_6.png",
    "assets/content6/content6_7.png",
    "assets/content6/content6_8.png",
    "assets/content6/content6_9.png",
    "assets/content6/content6_10.png",
  ];

  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    setState(() {
      currentPage = _pageController.page!.round() + 1;
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'การเปรียบเทียบ เรียงลำดับเศษส่วนและจำนวนคละ',
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: const Color.fromARGB(255, 203, 76, 225),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: contentImages.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    if (index > 0) {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  } else {
                    if (index < contentImages.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  }
                },
                child: Image.asset(
                  contentImages[index],
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    "$currentPage/${contentImages.length}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
