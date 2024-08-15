import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../quiz.dart';

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
