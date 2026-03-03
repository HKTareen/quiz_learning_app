import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/quiz_question_model.dart';
import 'quiz_api_service.dart';

part 'quiz_service.g.dart';

abstract class QuizService {
  const QuizService();

  Future<List<QuizQuestionModel>> fetchQuestions({
    required int category,
    required int amount,
    String difficulty = 'easy',
    String type = 'multiple',
  });
}

@riverpod
QuizService quizService(Ref ref) {
  return QuizApiService();
}
