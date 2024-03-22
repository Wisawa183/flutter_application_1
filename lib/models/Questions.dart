class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question": "1/2 + 1/2 = ?",
    "options": ['1', '12', '0', '2'],
    "answer_index": 0,
    "answerOfwrite": "1",
  },
  {
    "id": 2,
    "question": "4/2 + 4/2 = ?",
    "options": ['2/2', '1/4', '4', '2'],
    "answer_index": 2,
    "answerOfwrite": "1",
  },
  {
    "id": 3,
    "question": "4/8 + 4/8 = ?",
    "options": ['1', '2', '4', '8'],
    "answer_index": 0,
    "answerOfwrite": "1",
  },
];
