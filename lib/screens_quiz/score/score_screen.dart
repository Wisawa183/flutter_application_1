import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

var updatecore;

@override
void initState() {}

Future<void> updateChoicescore() async {
  try {
    // Get the document ID of the current user
    String? docID = await getDocumentId();

    // Check if docID is not null
    if (docID != null) {
      // Reference to the document in the "Profile" collection
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('Profile').doc(docID);

      // Update the "Choicescore" field with the value stored in updatecore
      await documentReference.update({
        'Choicescore': updatecore,
      });
      print(updatecore);

      print('Choicescore updated successfully.');
    } else {
      print('Document ID is null. Unable to update Choicescore.');
    }
  } catch (e) {
    print('Error updating Choicescore: $e');
  }
}

Future<String?> getDocumentId() async {
  try {
    String? userId;
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    String? userUID = FirebaseAuth.instance.currentUser?.uid;

    if (userEmail != null) {
      // Query the collection for the user with the specified email
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Profile')
          .where('Email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If the user with the specified email exists, get their document ID
        userId = querySnapshot.docs.first.id;
      }
    } else if (userUID != null) {
      // Query the collection for the user with the specified UID
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Profile')
          .where('Email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If the user with the specified UID exists, get their document ID
        userId = querySnapshot.docs.first.id;
      }
    }
    return userId;
  } catch (e) {
    print('Error getting document ID: $e');
    return null;
  }
}

void showScoreSummary(BuildContext context) {
  QuestionController _qnController = Get.find<QuestionController>();
  int totalQuestions = _qnController.questions.length;
  int totalCorrectAnswers = _qnController.correctAnswers.value ~/ 10;
  int totalIncorrectAnswers = totalQuestions - totalCorrectAnswers;

  int totalScore = (totalCorrectAnswers / totalQuestions * 100).toInt();
  updatecore = totalCorrectAnswers;
  updateChoicescore();

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
