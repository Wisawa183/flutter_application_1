import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/Questions.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../screens_quiz/score/score_screen.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late PageController _pageController;
  late List<Question> _questions;
  late bool _isAnswered;
  late int _correctAns;
  late int _selectedAns;
  late RxInt _questionNumber;
  late int _numOfCorrectAns;
  late RxInt correctanswer = 0.obs; // กำหนดค่าเริ่มต้นให้กับ correctanswer
  late RxInt score = 0.obs; // กำหนดค่าเริ่มต้นให้กับ score

  QuestionController() {
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    _questions = sample_data
        .map((question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']))
        .toList();
    _isAnswered = false;
    _correctAns = 0;
    _selectedAns = 0;
    _questionNumber = 1.obs;
    _numOfCorrectAns = 0;
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
      addCoins(10); // เพิ่มคะแนนเมื่อตอบถูก
      addScore(1); // เพิ่มคะแนน score ทีละ 1 เมื่อตอบถูก
    }

    _animationController.stop();
    update();

    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void addCoins(int amount) {
    correctanswer.value += amount;
  }

  void addScore(int amount) {
    score.value += amount;
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      showScoreSummary(Get.context!);
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  Animation<double> get animation => _animation;
  PageController get pageController => _pageController;
  List<Question> get questions => _questions;
  bool get isAnswered => _isAnswered;
  int get correctAns => _correctAns;
  int get selectedAns => _selectedAns;
  RxInt get questionNumber => _questionNumber;
  int get numOfCorrectAns => _numOfCorrectAns;
  RxInt get correctAnswers => correctanswer;
}
