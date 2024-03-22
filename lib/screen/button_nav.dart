import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/shop.dart';
import 'Exercise_menu.dart';
import 'Content_menu.dart';

class bottombar extends StatefulWidget {
  const bottombar({super.key});

  @override
  State<bottombar> createState() => _bottombarState();
}

class _bottombarState extends State<bottombar> {
  int currentIndex = 0;
  List widgetoptions = [
    Content_Menu(),
    Scrollbar(child: Exercise_menu()),
    Shop()
  ];

  List<String> titles = ['เนื้อหา', 'โหมดแบบฝึกหัด', 'ร้านค้า'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(titles[currentIndex]),
        ),
      ),
      body: Center(
        child: Material(
          // เพิ่ม Material widget ที่นี่
          elevation: 4.0, // ปรับค่า elevation ตามต้องการ
          child: widgetoptions[currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'เนื้อหา'),
          BottomNavigationBarItem(
              icon: Icon(Icons.gamepad), label: 'โหมดแบบฝึกหัด'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'โปรไฟล์'),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
