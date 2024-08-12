import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/core/api_client.dart';
import 'package:quiz_app/core/api_const.dart';
import 'package:quiz_app/features/quiz/data/model/question_model.dart';

abstract class QuestionDataSource {
  Future<List<QuestionModel>> getQuestionsDs();
}

class QuestionDataSourceImpl implements QuestionDataSource {
  ApiClient apiClient;
  QuestionDataSourceImpl({required this.apiClient});
  @override
  Future<List<QuestionModel>> getQuestionsDs() async {
    final result = await apiClient.request(path: ApiConst.questions);
    return QuestionModel.questionListFromJson(jsonEncode(result));
  }
}

final questionDataSourceProvider = Provider(
  (ref) => QuestionDataSourceImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);
