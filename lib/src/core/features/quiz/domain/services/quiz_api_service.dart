import '../../data/service/quiz_api.dart';
import '../models/quiz_question_model.dart';
import 'quiz_service.dart';

class QuizApiService extends QuizService {
  QuizApiService();

  @override
  Future<List<QuizQuestionModel>> fetchQuestions({
    required int category,
    required int amount,
    String difficulty = 'easy',
    String type = 'multiple',
  }) async {
    final dtoList = await QuizApi().fetchQuestions(
      category: category,
      amount: amount,
      difficulty: difficulty,
      type: type,
    );
    return dtoList.map((dto) => QuizQuestionModel.fromDto(dto)).toList();
  }
}
