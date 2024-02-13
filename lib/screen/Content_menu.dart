import 'package:flutter/material.dart';
import 'Content_1.dart';
import 'Content_2.dart';
import 'Content_3.dart';
import 'Content_4.dart';
import 'Content_5.dart';
import 'Content_6.dart';
import 'Content_7.dart';

class Content_Menu extends StatefulWidget {
  const Content_Menu({Key? key}) : super(key: key);

  @override
  State<Content_Menu> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Content_Menu> {
  List<List<dynamic>> menuList = [
    [
      "เศษส่วนแท้และเศษส่วนเกิน",
      "assets/images/menu_1.jpg",
      Color.fromARGB(255, 218, 241, 160)
    ],
    [
      "จำนวนคละ",
      "assets/images/menu_2.jpg",
      Color.fromARGB(255, 235, 143, 211)
    ],
    [
      "เศษส่วนเท่ากับจำนวณนับ",
      "assets/images/menu_3.jpg",
      Color.fromARGB(255, 120, 200, 238)
    ],
    [
      "เศษส่วนที่เท่ากัน",
      "assets/images/menu_4.jpg",
      Color.fromARGB(255, 236, 200, 149)
    ],
    [
      "เศษส่วนอย่างต่ำ",
      "assets/images/menu_5.jpg",
      const Color.fromARGB(255, 243, 160, 154)
    ],
    [
      "การเปรียบเทียบ เรียงลำดับเศษส่วนและจำนวนคละ",
      "assets/images/menu_6.jpg",
      Color.fromARGB(255, 157, 236, 228)
    ],
    [
      "การบวก การลบ การคูณ การหารระคนเศษส่วนและจำนวนคละ",
      "assets/images/menu_7.jpg",
      Color.fromARGB(255, 159, 236, 181)
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: menuList.length,
      itemBuilder: (_, index) {
        if (menuList.length > index && menuList[index].length > 2) {
          return InkWell(
            onTap: () {
              if (menuList[index][0] == "เศษส่วนแท้และเศษส่วนเกิน") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReadingScreen(menuData: menuList[index])),
                );
              }
              if (menuList[index][0] == "จำนวนคละ") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReadingScreen2(menuData: menuList[index])),
                );
              }
              if (menuList[index][0] == "เศษส่วนเท่ากับจำนวณนับ") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReadingScreen3(menuData: menuList[index])),
                );
              }
              if (menuList[index][0] == "เศษส่วนที่เท่ากัน") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReadingScreen4(menuData: menuList[index])),
                );
              }
              if (menuList[index][0] == "เศษส่วนอย่างต่ำ") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReadingScreen5(menuData: menuList[index])),
                );
              }
              if (menuList[index][0] ==
                  "การเปรียบเทียบ เรียงลำดับเศษส่วนและจำนวนคละ") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReadingScreen6(menuData: menuList[index])),
                );
              }
              if (menuList[index][0] ==
                  "การบวก การลบ การคูณ การหารระคนเศษส่วนและจำนวนคละ") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReadingScreen7(menuData: menuList[index])),
                );
              }
            },
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(30),
              color: menuList[index][2],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuList[index].length > 1
                      ? Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              menuList[index][1],
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 4),
                  Center(
                    child: Text(
                      menuList[index][0],
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
