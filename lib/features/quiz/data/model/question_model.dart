import 'dart:convert';

class QuestionModel {
  final Question questionText;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final List<String> options;
  String? userAnswer;

  QuestionModel({
    required this.questionText,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.options,
    this.userAnswer,
  }) {
    options.shuffle();
  }

  factory QuestionModel.fromJson(Map<String, dynamic> jsonData) {
    return QuestionModel(
      questionText: Question.fromJson(jsonData['question']),
      correctAnswer: jsonData['correctAnswer'] ?? "",
      incorrectAnswers:
          List<String>.from(jsonData["incorrectAnswers"].map((x) => x)),
      options: [
        ...List<String>.from(jsonData["incorrectAnswers"].map((x) => x)),
        jsonData['correctAnswer']
      ],
      userAnswer: jsonData['userAnswer'] ?? "",
    );
  }

  factory QuestionModel.fromStoredJson(Map<String, dynamic> jsonData) {
    return QuestionModel(
      questionText: Question.fromJson(jsonData['question']),
      correctAnswer: jsonData['correctAnswer'] ?? "",
      incorrectAnswers:
          List<String>.from(jsonData["incorrectAnswers"].map((x) => x)),
      options: List<String>.from(jsonData["options"].map((x) => x)),
      userAnswer: jsonData['userAnswer'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "question": questionText.toJson(),
      "correctAnswer": correctAnswer,
      "incorrectAnswers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
      "options": List<dynamic>.from(options.map((x) => x)),
      "userAnswer": userAnswer,
    };
  }

  static List<QuestionModel> questionListFromJson(String str) {
    return List<QuestionModel>.from(jsonDecode(str).map((question) {
      return QuestionModel.fromJson(question);
    }));
  }

  static List<QuestionModel> answerListFromJson(String str) {
    return List<QuestionModel>.from(jsonDecode(str).map((question) {
      return QuestionModel.fromStoredJson(question);
    }));
  }

  static String answerListToJson(List<QuestionModel> data) =>
      json.encode(List<dynamic>.from(data.map((answer) => answer.toJson())));
}

class Question {
  String text;

  Question({
    required this.text,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}
