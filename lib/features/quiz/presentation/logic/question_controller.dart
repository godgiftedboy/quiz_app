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

class QuestionController extends AutoDisposeAsyncNotifier<List<QuestionModel>> {
  @override
  FutureOr<List<QuestionModel>> build() async {
    // state = const AsyncValue.loading();
    return getAllQuestions();
  }

  Future<List<QuestionModel>> getAllQuestions() async {
    final result = await ref.read(questionRepositoryProvider).getQuestions();
    return result.fold(
      (l) {
        // state = AsyncValue.error(l.message, StackTrace.current);
        throw l.message;
      },
      (r) {
        // state = AsyncValue.data(r);
        return r;
      },
    );
  }
}

final questionControllerProvider =
    AutoDisposeAsyncNotifierProvider<QuestionController, List<QuestionModel>>(
        QuestionController.new);
