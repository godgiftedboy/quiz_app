import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/features/quiz/data/model/question_model.dart';
import 'package:quiz_app/features/quiz/data/repository/question_repository.dart';

// class QuestionController
//     extends StateNotifier<AsyncValue<List<QuestionModel>>> {
//   final QuestionRepository _questionRepository;
//   QuestionController(this._questionRepository)
//       : super(const AsyncValue.loading()) {
//     getAllQuestions();
//   }
//   getAllQuestions() async {
//     final result = await _questionRepository.getQuestions();
//     return result.fold(
//       (l) {
//         state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
//       },
//       (r) {
//         state = AsyncValue.data(r);
//       },
//     );
//   }

//   resetState() {
//     state = const AsyncValue.data([]);
//   }
// }

// final questionControllerProvider =
//     StateNotifierProvider<QuestionController, AsyncValue<List<QuestionModel>>>(
//   (ref) => QuestionController(
//     ref.read(questionRepositoryProvider),
//   ),
// );

class QuestionController extends AsyncNotifier<List<QuestionModel>> {
  @override
  FutureOr<List<QuestionModel>> build() {
    return getAllQuestions();
  }

  getAllQuestions() async {
    final result = await ref.read(questionRepositoryProvider).getQuestions();
    return result.fold(
      (l) {
        state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
      },
      (r) {
        state = AsyncValue.data(r);
      },
    );
  }

  resetState() {
    state = const AsyncValue.data([]);
  }
}

final questionControllerProvider =
    AsyncNotifierProvider<QuestionController, List<QuestionModel>>(
        QuestionController.new);
