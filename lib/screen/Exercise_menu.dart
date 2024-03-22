import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/Exercise_7.dart';

class Exercise_menu extends StatefulWidget {
  const Exercise_menu({Key? key}) : super(key: key);

  @override
  State<Exercise_menu> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Exercise_menu> {
  List<List<dynamic>> menulist = [
    ["เศษส่วนแท้และเศษส่วนเกิน", "assets/images/menu_1.jpg"],
    ["จำนวนคละ", "assets/images/menu_2.jpg"],
    ["เศษส่วนเท่ากับจำนวณนับ", "assets/images/menu_3.jpg"],
    ["เศษส่วนที่เท่ากัน", "assets/images/menu_4.jpg"],
    ["เศษส่วนอย่างต่ำ", "assets/images/menu_5.jpg"],
    ["การเปรียบเทียบ เรียงลำดับเศษส่วนและจำนวนคละ", "assets/images/menu_6.jpg"],
    [
      "การบวก การลบ การคูณ การหารระคนเศษส่วนและจำนวนคละ",
      "assets/images/menu_7.jpg"
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menulist.length,
      itemBuilder: (_, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: menulist[index].length > 1
                ? Image.asset(
                    menulist[index][1],
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  )
                : SizedBox.shrink(),
            title: Text(
              menulist[index][0],
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              if (index == 6) {
                // ตรวจสอบว่าเมื่อกดที่รายการ "การบวก การลบ การคูณ การหารระคนเศษส่วนและจำนวนคละ"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Exercise_7(), // ไปยังหน้า Exercise_7
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
