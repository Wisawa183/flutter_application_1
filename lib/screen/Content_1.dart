import 'package:flutter/material.dart';

class ReadingScreen extends StatefulWidget {
  final List<dynamic> menuData;

  ReadingScreen({Key? key, required this.menuData}) : super(key: key);

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  List<String> contentImages = [
    "assets/content1/content1_1.png",
    "assets/content1/content1_2.png",
    "assets/content1/content1_3.png",
    "assets/content1/content1_4.png",
    "assets/content1/content1_5.png",
    "assets/content1/content1_6.png",
    "assets/content1/content1_7.png",
    "assets/content1/content1_8.png",
    "assets/content1/content1_9.png",
    "assets/content1/content1_10.png",
    "assets/content1/content1_11.png",
  ];

  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 1;
  bool isDragging = false;

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
        title: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: isDragging ? 0 : 1,
          child: Text('เศษส่วนแท้และเศษส่วนเกิน'),
        ),
        backgroundColor: const Color.fromARGB(255, 203, 76, 225),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: contentImages.length,
            physics: isDragging ? NeverScrollableScrollPhysics() : null,
            itemBuilder: (context, index) {
              return GestureDetector(
                onHorizontalDragStart: (_) {
                  setState(() {
                    isDragging = true;
                  });
                },
                onHorizontalDragEnd: (details) {
                  setState(() {
                    isDragging = false;
                  });
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
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: isDragging ? 0.5 : 1,
                  child: Image.asset(
                    contentImages[index],
                    fit: BoxFit.contain,
                  ),
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
