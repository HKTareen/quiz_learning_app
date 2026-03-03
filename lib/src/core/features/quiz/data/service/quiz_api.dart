import 'package:dio/dio.dart';

import '../dto/quiz_question_dto.dart';

class QuizApi {
  final Dio _dio = Dio();

  Future<List<QuizQuestionDto>> fetchQuestions({
    required int category,
    required int amount,
    String difficulty = 'easy',
    String type = 'multiple',
  }) async {
    try {
      final response = await _dio.get(
        'https://opentdb.com/api.php',
        queryParameters: {
          'amount': amount,
          'category': category,
          'difficulty': difficulty,
          'type': type,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final resultsList = data['results'] as List;
        final results = resultsList
            .map((json) {
              // Decode HTML entities in the response
              final decodedJson = Map<String, dynamic>.from(json as Map<String, dynamic>);
              decodedJson['question'] = _decodeHtml(decodedJson['question'] as String);
              decodedJson['correct_answer'] = _decodeHtml(decodedJson['correct_answer'] as String);
              final incorrect = (decodedJson['incorrect_answers'] as List)
                  .map((e) => _decodeHtml(e as String))
                  .toList();
              decodedJson['incorrect_answers'] = incorrect;
              return QuizQuestionDto.fromJson(decodedJson);
            })
            .toList();
        return results;
      } else {
        throw 'Failed to fetch questions';
      }
    } catch (e) {
      throw 'Failed to fetch questions: ${e.toString()}';
    }
  }

  String _decodeHtml(String html) {
    return html
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&nbsp;', ' ');
  }
}
