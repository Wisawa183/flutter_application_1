import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/controllers/question_controller.dart';
import 'package:flutter_application_1/screen/Exercise_7P2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/icons/bg.svg",
            fit: BoxFit.fill,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(206, 130, 219, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 3),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 210, 237),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "คะแนน",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Color(0xFF800080),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Spacer(flex: 1),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 210, 237),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(() => Text(
                        "${_qnController.correctAnswers.value ~/ 10}/${_qnController.questions.length}",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Color(0xFF800080),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                      )),
                ),
                Spacer(flex: 1),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 210, 237),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(() => Text(
                        "Coins + ${_qnController.correctAnswers.value} !",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Color(0xFF800080),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                      )),
                ),
                Spacer(flex: 3),
                ElevatedButton(
                  onPressed: () {
                    showScoreSummary(context);
                  },
                  child: Text('แสดงสรุปคะแนน'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showScoreSummary(BuildContext context) {
  QuestionController _qnController = Get.find<QuestionController>();
  int totalQuestions = _qnController.questions.length;
  int totalCorrectAnswers = _qnController.correctAnswers.value ~/ 10;
  int totalIncorrectAnswers = totalQuestions - totalCorrectAnswers;

  int totalScore = (totalCorrectAnswers / totalQuestions * 100).toInt();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('สรุปคะแนน'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('คะแนนที่ได้: $totalScore%'),
            Text('คำตอบที่ถูก: $totalCorrectAnswers'),
            Text('คำตอบที่ผิด: $totalIncorrectAnswers'),
            Text('จำนวนข้อทั้งหมด: $totalQuestions'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด Dialog
            },
            child: Text('กลับหน้าหลัก'),
          ),
          ElevatedButton(
            onPressed: () {
              // เรียกฟังก์ชันหรือส่งข้อมูลไปยังหน้าที่เรียกใช้งานหน้าจอใหม่
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Exercise_7P2(), // หน้าจอหลัก
                ),
              );
            },
            child: Text('เริ่มเล่นใหม่'),
          ),
        ],
      );
    },
  );
}
