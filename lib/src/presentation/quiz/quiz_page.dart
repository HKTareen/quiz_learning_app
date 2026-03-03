import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/features/quiz/domain/models/quiz_category_model.dart';
import '../../core/features/quiz/domain/models/quiz_result_model.dart';
import '../../core/features/quiz/domain/provider/quiz_provider.dart';
import '../../core/features/user/domain/provider/user_provider.dart';
import '../../extensions/custom_extensions.dart';
import '../../widget/app_background_widget.dart';
import '../../widget/app_button_widget.dart';
import '../main/main_tab_page.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage.builder(
    BuildContext context,
    GoRouterState state, {
    super.key,
    this.category,
  });

  static const path = '/quiz';
  static const name = 'quiz';

  final QuizCategoryModel? category;

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  bool _showFeedback = false;
  bool _isCorrect = false;
  Timer? _timer;
  int _timeRemaining = 60;
  bool _isCountdown = true;
  int _countdownValue = 3;
  final List<bool> _answers = [];
  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() async {
    for (int i = 3; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _countdownValue = i;
        });
      }
    }
    if (mounted) {
      setState(() {
        _isCountdown = false;
      });
      _loadQuestions();
    }
  }

  void _loadQuestions() async {
    if (widget.category == null) return;

    final questions = await ref.read(
      fetchQuizQuestionsProvider(
        category: widget.category!.id,
        amount: 10,
      ).future,
    );

    if (mounted) {
      ref.read(quizStateProvider.notifier).setQuestions(questions);
      _startTimer();
    }
  }

  void _startTimer() {
    _timeRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timeRemaining > 0) {
            _timeRemaining--;
          } else {
            timer.cancel();
            if (!_showFeedback) {
              _handleAnswer(null);
            }
          }
        });
      }
    });
  }

  void _handleAnswer(String? answer) {
    if (_showFeedback) return;

    final questions = ref.read(quizStateProvider);
    if (_currentQuestionIndex >= questions.length) return;

    final question = questions[_currentQuestionIndex];
    final isCorrect = answer == question.correctAnswer;

    setState(() {
      _selectedAnswer = answer;
      _showFeedback = true;
      _isCorrect = isCorrect;
    });

    _timer?.cancel();

    // Track answer
    _answers.add(isCorrect);
    if (isCorrect) {
      _totalScore += 10;
    }

    // Wait 1 second then move to next question
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        if (_currentQuestionIndex < questions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _selectedAnswer = null;
            _showFeedback = false;
            _timeRemaining = 60;
          });
          _startTimer();
        } else {
          _finishQuiz();
        }
      }
    });
  }

  void _finishQuiz() {
    final questions = ref.read(quizStateProvider);
    final correctCount = _answers.where((isCorrect) => isCorrect).length;

    // Update user score
    final currentScore = ref.read(currentUserProvider)?.score ?? 0;
    ref.read(currentUserProvider.notifier).updateScore(currentScore + _totalScore);

    final result = QuizResultModel(
      totalQuestions: questions.length,
      correctAnswers: correctCount,
      score: _totalScore,
    );

    ref.read(quizResultProvider.notifier).setResult(result);

    // Update category progress
    if (widget.category != null) {
      final progress = ((_currentQuestionIndex + 1) / questions.length * 100).round();
      ref.read(quizCategoriesProvider.notifier).updateCategoryProgress(
            widget.category!.id,
            progress,
          );
    }

    // Show result dialog
    _showResultDialog(result);
  }

  void _showResultDialog(QuizResultModel result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Total Questions: ${result.totalQuestions}'),
            Text('Correct Answers: ${result.correctAnswers}'),
            Text('Score: ${result.score}'),
            Text('Percentage: ${result.percentage}%'),
          ],
        ),
        actions: [
          AppButtonWidget(
            title: 'Back to Home',
            onPressed: () {
              Navigator.of(context).pop();
              context.goNamed(MainTabPage.name);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(quizStateProvider);
    final deviceType = context.deviceType;

    if (_isCountdown) {
      return Scaffold(
        body: Center(
          child: Text(
            '$_countdownValue',
            style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentQuestionIndex >= questions.length) {
      return const Scaffold(
        body: Center(child: Text('Quiz Complete')),
      );
    }

    final question = questions[_currentQuestionIndex];
    final progress = ((_currentQuestionIndex + 1) / questions.length * 100).round();

    return Scaffold(
      body: AppBackgroundWidget(
        body: Column(
          children: [
            // Progress bar
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_currentQuestionIndex + 1}/${questions.length}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$progress%',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / questions.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ],
              ),
            ),
            // Timer
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: LinearProgressIndicator(
                value: _timeRemaining / 60,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _timeRemaining < 10 ? Colors.red : Colors.green,
                ),
              ),
            ),
            // Question and Answers
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceType == DeviceType.mobile ? 20 : 40,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question
                    Text(
                      question.question,
                      style: TextStyle(
                        fontSize: deviceType == DeviceType.mobile ? 20 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Answers
                    ...question.allAnswers.map((answer) {
                      final isSelected = _selectedAnswer == answer;
                      final isCorrectAnswer = answer == question.correctAnswer;
                      Color? borderColor;
                      String? feedbackLabel;

                      if (_showFeedback) {
                        if (isCorrectAnswer) {
                          borderColor = Colors.green;
                        } else if (isSelected && !isCorrectAnswer) {
                          borderColor = Colors.red;
                        }
                        if (isSelected) {
                          feedbackLabel = _isCorrect ? 'Correct' : 'Incorrect';
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            if (!_showFeedback) {
                              _handleAnswer(answer);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: borderColor ?? Colors.black,
                                width: borderColor != null ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    answer,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                if (feedbackLabel != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _isCorrect ? Colors.green : Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      feedbackLabel,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
