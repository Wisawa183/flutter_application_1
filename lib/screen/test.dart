import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController _questionIdController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _choiceController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  void _submitQuestion() {
    String questionId = _questionIdController.text.trim();
    String question = _questionController.text.trim();
    List<String> choices = _choiceController.text.trim().split(',');
    String answer = _answerController.text.trim();

    // Send data to Firebase
    FirebaseFirestore.instance.collection('questions').doc(questionId).set({
      'question': question,
      'choices': choices,
      'answer': answer,
    }).then((value) {
      // Clear input fields after successful submission
      _questionIdController.clear();
      _questionController.clear();
      _choiceController.clear();
      _answerController.clear();
    }).catchError((error) {
      // Handle error
      print("Failed to add question: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _questionIdController,
              decoration: InputDecoration(labelText: 'Question ID'),
            ),
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: _choiceController,
              decoration:
                  InputDecoration(labelText: 'Choices (comma-separated)'),
            ),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(labelText: 'Answer'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitQuestion,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
