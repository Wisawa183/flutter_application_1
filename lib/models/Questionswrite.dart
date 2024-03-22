class Questionwrite {
  final dynamic id, answer;
  final String question;
  final List<String> options;
  final String answerOfwrite; // เพิ่มพารามิเตอร์ answerOfwrite

  Questionwrite(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options,
      required this.answerOfwrite}); // นิยามพารามิเตอร์ answerOfwrite ในคอนสตรักเตอร์
}

const List write_data = [
  {
    "id": 1,
    "question": "1/2 + 1/2 = ",
    "options": ['1', '12', '0', '2'],
    "answer_index": 0,
    "answerOfwrite": "1/3",
  },
  {
    "id": 2,
    "question": "4/2 + 4/2 = ",
    "options": ['2/2', '1/4', '1/4', '2'],
    "answer_index": 2,
    "answerOfwrite": "4",
  },
  {
    "id": 3,
    "question": "4/8 + 4/8 = ",
    "options": ['1', '2', '4', '8'],
    "answer_index": 0,
    "answerOfwrite": "1",
  },
  {
    "id": 4,
    "question": "1/3 + 2/3 = ",
    "options": ['1', '3/2', '3', '2/3'],
    "answer_index": 1,
    "answerOfwrite": "1",
  },
  {
    "id": 5,
    "question": "3/5 + 1/5 = ",
    "options": ['2/5', '4/5', '1/5', '3/5'],
    "answer_index": 3,
    "answerOfwrite": "4/5",
  },
  {
    "id": 6,
    "question": "2/4 + 3/4 = ",
    "options": ['5/4', '1', '1/2', '1/4'],
    "answer_index": 0,
    "answerOfwrite": "5/4",
  },
  {
    "id": 7,
    "question": "5/6 + 1/6 = ",
    "options": ['6/6', '2/6', '1/3', '1'],
    "answer_index": 2,
    "answerOfwrite": "1/3",
  },
  {
    "id": 8,
    "question": "3/8 + 5/8 = ",
    "options": ['1', '4/8', '1/2', '8/8'],
    "answer_index": 3,
    "answerOfwrite": "8/8",
  },
  {
    "id": 9,
    "question": "2/9 + 3/9 = ",
    "options": ['2/3', '1', '5/9', '1/3'],
    "answer_index": 2,
    "answerOfwrite": "5/9",
  },
  {
    "id": 10,
    "question": "3/7 + 4/7 = ",
    "options": ['1', '7/7', '2/7', '7/4'],
    "answer_index": 1,
    "answerOfwrite": "7/7",
  },
  {
    "id": 11,
    "question": "1/10 + 3/10 = ",
    "options": ['2/10', '3/5', '1/5', '4/10'],
    "answer_index": 3,
    "answerOfwrite": "4/10",
  },
  {
    "id": 12,
    "question": "4/12 + 2/12 = ",
    "options": ['1/6', '1/2', '2/12', '1/4'],
    "answer_index": 0,
    "answerOfwrite": "1/6",
  },
  {
    "id": 13,
    "question": "5/11 + 1/11 = ",
    "options": ['6/11', '1', '3/11', '2/11'],
    "answer_index": 0,
    "answerOfwrite": "6/11",
  },
  {
    "id": 14,
    "question": "2/15 + 4/15 = ",
    "options": ['6/15', '1', '2/5', '3/15'],
    "answer_index": 0,
    "answerOfwrite": "6/15",
  },
  {
    "id": 15,
    "question": "1/8 + 1/8 = ",
    "options": ['1/4', '2/8', '8/8', '1'],
    "answer_index": 1,
    "answerOfwrite": "2/8",
  },
  {
    "id": 16,
    "question": "3/16 + 5/16 = ",
    "options": ['4/16', '1', '8/16', '1/4'],
    "answer_index": 2,
    "answerOfwrite": "8/16",
  },
  {
    "id": 17,
    "question": "4/20 + 3/20 = ",
    "options": ['1/10', '1/4', '1/5', '1'],
    "answer_index": 0,
    "answerOfwrite": "1/10",
  },
  {
    "id": 18,
    "question": "5/17 + 2/17 = ",
    "options": ['7/17', '1/17', '3/17', '2/17'],
    "answer_index": 0,
    "answerOfwrite": "7/17",
  }
];
