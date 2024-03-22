import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Questionswrite.dart';
import 'package:flutter_application_1/screen/Exercise_7P2.dart';

import 'const.dart';
import 'my_button.dart';
import 'result_message.dart';

// นิยามคลาส Fraction
class Fraction {
  int numerator;
  int denominator;

  Fraction(this.numerator, this.denominator);

  @override
  String toString() {
    return '$numerator/$denominator';
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '/',
    '=',
    '0',
  ];

  String userAnswerText = '';
  int timeLeft = 30;
  int currentQuestion = 1;
  late List<Map<String, dynamic>> sampleData;
  late Questionwrite currentQuestionData;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  late Timer timer;
  bool isDialogShowing = false;

  bool isButtonVisible = true;

  @override
  void initState() {
    super.initState();
    startTimer();
    List<Map<String, dynamic>> randomQuestions = getRandomQuestions(10);
    sampleData = randomQuestions.cast<Map<String, dynamic>>();
    currentQuestionData = _parseQuestion(sampleData[0]);
  }

  List<Map<String, dynamic>> getRandomQuestions(int count) {
    List<Map<String, dynamic>> selectedQuestions = [];
    Random random = Random();
    Set<int> selectedIndexes = {};

    while (selectedQuestions.length < count) {
      int randomIndex = random.nextInt(write_data.length);
      if (!selectedIndexes.contains(randomIndex)) {
        selectedQuestions.add(write_data[randomIndex]);
        selectedIndexes.add(randomIndex);
      }
    }
    return selectedQuestions;
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0 && !isDialogShowing) {
          timeLeft--;
        } else {
          timer.cancel();
          if (!isDialogShowing) {
            timeLeft = 10;
            if (currentQuestion < sampleData.length) {
              showTimeUpDialog();
              startTimer();
            } else {
              showScoreSummary();
            }
          }
        }
      });
    });
  }

  int pressedCount = 0; // ตัวแปรเก็บจำนวนครั้งที่กดปุ่ม
  int remainingButtonPresses = 2; // เก็บจำนวนครั้งที่เหลือในการกดปุ่ม

  void addTime() {
    setState(() {
      if (remainingButtonPresses > 0) {
        if (timeLeft < 20) {
          timeLeft += 10;
        } else {
          timeLeft = 30;
        }
        remainingButtonPresses--; // ลดจำนวนครั้งที่เหลือในการกดปุ่ม
        if (remainingButtonPresses == 0) {
          isButtonVisible = false; // ถ้าครบจำนวนครั้งแล้วให้ซ่อนปุ่ม
        }
      }
    });
  }

  void showTimeUpDialog() {
    if (!isDialogShowing) {
      isDialogShowing = true;
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'หมดเวลา!',
            onTep: () {
              isDialogShowing = false;
              incorrectAnswers++;
              goToNextQuestion();
            },
            IconData: Icons.arrow_forward,
          );
        },
      );
    }
  }

  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        if (userAnswerText.isNotEmpty) {
          // Check if user provided a fraction answer
          if (userAnswerText.contains('/')) {
            List<String> inputParts = userAnswerText.split('/');
            if (inputParts.length == 2) {
              int? numerator = int.tryParse(inputParts[0]);
              int? denominator = int.tryParse(inputParts[1]);

              if (numerator != null &&
                  denominator != null &&
                  denominator != 0) {
                userAnswerText = '';
                Fraction userAnswer = Fraction(numerator, denominator);
                checkResult(userAnswer.toString());
              }
            }
          } else {
            // Check if user provided a numeric answer
            int? userNumericAnswer = int.tryParse(userAnswerText);
            if (userNumericAnswer != null) {
              checkResult(userNumericAnswer.toString());
            }
          }
        }
      } else if (button == 'C') {
        userAnswerText = '';
      } else if (button == 'DEL') {
        if (userAnswerText.isNotEmpty) {
          userAnswerText =
              userAnswerText.substring(0, userAnswerText.length - 1);
        }
      } else if (button == '/') {
        if (userAnswerText.isNotEmpty && !userAnswerText.contains('/')) {
          userAnswerText += '/';
        }
      } else if (button == '0' ||
          button == '1' ||
          button == '2' ||
          button == '3' ||
          button == '4' ||
          button == '5' ||
          button == '6' ||
          button == '7' ||
          button == '8' ||
          button == '9') {
        userAnswerText += button;
      }
    });
  }

  void checkResult(String userAnswer) {
    if (currentQuestionData.answerOfwrite == userAnswer) {
      // ตอบถูก
      if (!isDialogShowing) {
        isDialogShowing = true;
        showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'ถูกต้อง!',
              onTep: () {
                isDialogShowing = false;
                correctAnswers++;
                goToNextQuestion();
              },
              IconData: Icons.arrow_forward,
            );
          },
        );
      }
    } else {
      // ตอบผิด
      if (!isDialogShowing) {
        isDialogShowing = true;
        showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'คำตอบผิด!',
              onTep: () {
                isDialogShowing = false;
                incorrectAnswers++;
                goToNextQuestion();
              },
              IconData: Icons.arrow_forward,
            );
          },
        );
      }
    }
  }

  void showScoreSummary() {
    int totalQuestions = sampleData.length;
    int totalCorrectAnswers = correctAnswers;
    int totalIncorrectAnswers = incorrectAnswers;

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
              Text('จำนวนข้อทั้งหมด: $totalQuestions'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Exercise_7P2(), // หน้าจอหลัก
                  ),
                ); // ปิด Dialog
              },
              child: Text('กลับหน้าหลัก'),
            ),
            ElevatedButton(
              onPressed: () {
                // เรียกฟังก์ชันหรือส่งข้อมูลไปยังหน้าที่เรียกใช้งานหน้าจอใหม่
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(), // หน้าจอหลัก
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

  Fraction nextRandomFraction() {
    int numerator;
    int denominator;

    do {
      denominator = Random().nextInt(10) + 1;
      numerator = Random().nextInt(denominator);
    } while (numerator == 0);

    return Fraction(numerator, denominator);
  }

  void goToNextQuestion() {
    if (currentQuestion < sampleData.length) {
      currentQuestion++;
      setState(() {
        currentQuestionData = _parseQuestion(sampleData[currentQuestion - 1]);
        userAnswerText = '';
        timeLeft = 30;
      });
      isDialogShowing = false;
      Navigator.of(context).pop();
      startTimer();
    } else {
      // เรียกฟังก์ชันสรุปคะแนนเมื่อเล่นข้อสุดท้ายเสร็จสิ้น
      showScoreSummary();
    }
  }

  void goBackToQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswerText = '';
    });
  }

  Questionwrite _parseQuestion(Map<String, dynamic> data) {
    List<String> options = List<String>.from(data['options']);
    String answerOfwrite = data['answerOfwrite'];

    // Check if the answer is a fraction
    if (answerOfwrite.contains('/') && answerOfwrite.split('/').length == 2) {
      return Questionwrite(
        id: data['id'],
        question: data['question'],
        answer: answerOfwrite, // Store the fraction as a string
        options: options,
        answerOfwrite: answerOfwrite,
      );
    }

    // Check if the answer is an integer
    if (int.tryParse(answerOfwrite) != null) {
      return Questionwrite(
        id: data['id'],
        question: data['question'],
        answer: int.parse(answerOfwrite),
        options: options,
        answerOfwrite: answerOfwrite,
      );
    }

    // If unable to parse the answer, return a default question
    return Questionwrite(
      id: data['id'],
      question: data['question'],
      answer: 0, // or any default value that makes sense
      options: options,
      answerOfwrite: answerOfwrite,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 70,
                  color: Colors.deepPurple,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentQuestionData.question,
                            style: whiteTextStyle,
                          ),
                          SizedBox(
                              height:
                                  10), // Add space between question and answer input
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[500],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                userAnswerText,
                                style: whiteTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: numberPad.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (context, index) {
                        return MyButton(
                          child: numberPad[index],
                          onTap: () => buttonTapped(numberPad[index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 28,
              left: 5,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 89, 17, 124),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'ข้อ $currentQuestion/${sampleData.length}',
                  style: whiteTextStyle.copyWith(fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: 28,
              right: 5,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 89, 17, 124),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'เวลาที่เหลือ : $timeLeft',
                  style: whiteTextStyle.copyWith(fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: 75,
              right: 5,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 89, 17, 124),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Text(
                      'คะแนน: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'ถูก ',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '$correctAnswers',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '  /  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'ผิด ',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '$incorrectAnswers',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 75,
              left: 5,
              child: AnimatedOpacity(
                opacity: isButtonVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: ElevatedButton.icon(
                  onPressed: () {
                    addTime();
                  },
                  icon: Icon(Icons.access_time),
                  label: Text(
                    'เหลือ $remainingButtonPresses ครั้ง',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
