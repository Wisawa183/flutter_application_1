import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens_quiz/quiz/quiz_screen.dart';

import 'Exercise_7P2.dart';

class Exercise_7 extends StatelessWidget {
  final List<List<dynamic>> menulist = [
    ["การบวกเศษส่วน", Icons.add],
    ["การลบเศษส่วน", Icons.remove],
    ["การคูณเศษส่วน", Icons.close],
    ["การหารเศษส่วน", CupertinoIcons.divide],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('การบวก การลบ การคูณ การหารระคนเศษส่วนและจำนวนคละ'),
      ),
      body: ListView.builder(
        itemCount: menulist.length,
        itemBuilder: (context, index) {
          final String title = menulist[index][0];
          final IconData icon = menulist[index][1];

          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Icon(
                icon,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                // เมื่อไอเทมถูกคลิก และเป็น "การบวกเศษส่วน" เท่านั้น
                if (title == "การบวกเศษส่วน") {
                  // เรียก Navigator.of(context).push() เพื่อเปิดหน้า QuizScreen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Exercise_7P2(),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
