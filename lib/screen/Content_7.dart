import 'package:flutter/material.dart';

class ReadingScreen7 extends StatefulWidget {
  final List<dynamic> menuData;

  ReadingScreen7({Key? key, required this.menuData}) : super(key: key);

  @override
  _ReadingScreen7State createState() => _ReadingScreen7State();
}

class _ReadingScreen7State extends State<ReadingScreen7> {
  List<String> contentImages = [
    "assets/content7/content7_1.png",
    "assets/content7/content7_2.png",
    "assets/content7/content7_3.png",
    "assets/content7/content7_4.png",
    "assets/content7/content7_5.png",
    "assets/content7/content7_6.png",
    "assets/content7/content7_7.png",
    "assets/content7/content7_8.png",
    "assets/content7/content7_9.png",
    "assets/content7/content7_10.png",
    "assets/content7/content7_11.png",
    "assets/content7/content7_12.png",
    "assets/content7/content7_13.png",
    "assets/content7/content7_14.png",
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
          'การบวก การลบ การคูณ การหารระคนเศษส่วนและจำนวนคละ',
          style: TextStyle(fontSize: 12),
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
