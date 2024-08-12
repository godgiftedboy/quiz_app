import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/features/quiz/data/model/question_model.dart';
import 'package:quiz_app/features/quiz/data/repository/question_repository.dart';

class QuestionController extends StateNotifier<List<QuestionModel>> {
  final QuestionRepository _questionRepository;
  QuestionController(this._questionRepository) : super([]) {
    getAllQuestions();
  }
  getAllQuestions() async {
    final result = await _questionRepository.getQuestions();
    return result.fold(
      (l) {
        state = [];
      },
      (r) {
        state = [...r];
      },
    );
  }
}

final questionControllerProvider =
    StateNotifierProvider<QuestionController, List<QuestionModel>>(
  (ref) => QuestionController(
    ref.read(questionRepositoryProvider),
  ),
);
