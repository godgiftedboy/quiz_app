import 'dart:convert';

class QuestionModel {
  final String questionText;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final List<String> options;

  QuestionModel({
    required this.questionText,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.options,
  }) {
    options.shuffle();
  }

  factory QuestionModel.fromJson(Map<String, dynamic> jsonData) {
    return QuestionModel(
      questionText: jsonData['question']['text'] ?? "",
      correctAnswer: jsonData['correctAnswer'] ?? "",
      incorrectAnswers:
          List<String>.from(jsonData["incorrectAnswers"].map((x) => x)),
      options: [
        ...List<String>.from(jsonData["incorrectAnswers"].map((x) => x)),
        jsonData['correctAnswer']
      ],
    );
  }

  static List<QuestionModel> questionListFromJson(String str) {
    return List<QuestionModel>.from(jsonDecode(str).map((question) {
      return QuestionModel.fromJson(question);
    }));
  }
}
