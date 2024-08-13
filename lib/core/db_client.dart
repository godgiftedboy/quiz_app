import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/features/quiz/data/model/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dbClientProvider = Provider<DbClient>((ref) {
  return DbClient();
});

class DbClient {
  saveUser(String username) async {
    final prefs = await SharedPreferences.getInstance();

    var userList = prefs.getStringList("userList");

    await prefs.setStringList("userList", [...?userList, username]);
  }

  Future<List<String>> getUserList() async {
    final prefs = await SharedPreferences.getInstance();
    var userList = prefs.getStringList("userList") ?? [];
    print("From getuserList: $userList");
    return userList;
  }

  saveScore(String username, String score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(username, score);
  }

  Future<String> getScore(String username) async {
    final prefs = await SharedPreferences.getInstance();
    var score = prefs.getString(username) ?? "";
    return score;
  }

  saveUserAnswers(String username, List<QuestionModel> userAnswerList) async {
    final prefs = await SharedPreferences.getInstance();
    var userAnswerListStr = QuestionModel.answerListToJson(userAnswerList);
    prefs.setString("${username}answer", userAnswerListStr);
  }

  Future<List<QuestionModel>> getUserAnswers(String username) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString("${username}answer");
    var userAnswerList = QuestionModel.answerListFromJson(data!);
    return userAnswerList;
  }

  removeAll() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove("userList");
  }
}
