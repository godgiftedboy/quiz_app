import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/features/quiz/data/model/question_model.dart';

final userAnswerProvider =
    StateNotifierProvider<UserAnswerController, List<QuestionModel>>((ref) {
  return UserAnswerController();
});

class UserAnswerController extends StateNotifier<List<QuestionModel>> {
  UserAnswerController() : super([]);

  void addAnswerToList(QuestionModel answer) {
    state = [...state, answer];

    // var heel = QuestionModel.answerListToJson(state);
    // print("test case for model: $heel");

    // var data = QuestionModel.answerListFromJson(heel);
    // print(data);
    // print("test case for data from json: $data");
  }

  resetState() {
    state = [];
  }
}
