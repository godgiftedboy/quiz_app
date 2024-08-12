import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quiz_app/core/app_error.dart';
import 'package:quiz_app/core/exception_handle.dart';
import 'package:quiz_app/features/quiz/data/data_source/question_data_source.dart';
import 'package:quiz_app/features/quiz/data/model/question_model.dart';

abstract class QuestionRepository {
  Future<Either<AppError, List<QuestionModel>>> getQuestions();
}

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionDataSource questionDataSource;
  QuestionRepositoryImpl({required this.questionDataSource});
  @override
  Future<Either<AppError, List<QuestionModel>>> getQuestions() async {
    try {
      final result = await questionDataSource.getQuestionsDs();
      return Right(result);
    } on DioExceptionHandle catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final questionRepositoryProvider = Provider(
  (ref) => QuestionRepositoryImpl(
    questionDataSource: ref.read(questionDataSourceProvider),
  ),
);
