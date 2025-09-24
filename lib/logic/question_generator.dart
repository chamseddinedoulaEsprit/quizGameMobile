import 'dart:math';
import '../models/game_models.dart';
import '../services/data_service.dart';

class QuestionGenerator {
  final Random _random = Random();
  final Set<int> _usedQuestionIndices = {};
  late List<Question> _availableQuestions;
  
  QuestionGenerator(List<String> categories, int questionsPerCategory) {
    // Get questions from the repository based on selected categories
    _availableQuestions = QuestionRepository.getQuestionsByCategories(
      categories,
      questionsPerCategory,
    );
  }

  // Get the total number of available questions
  int get totalQuestions => _availableQuestions.length;

  // Get all available questions (shuffled)
  List<Question> getAllQuestions() {
    return List.from(_availableQuestions)..shuffle();
  }

  // Get questions by difficulty level
  List<Question> getQuestionsByDifficulty(int difficulty) {
    return _availableQuestions
        .where((q) => q.difficulty == difficulty)
        .toList()
        ..shuffle();
  }

  // Get questions by category
  List<Question> getQuestionsByCategory(String category) {
    return _availableQuestions
        .where((q) => q.category == category)
        .toList()
        ..shuffle();
  }

  // Get a random question that hasn't been used before
  Question? getRandomQuestion() {
    if (_usedQuestionIndices.length >= _availableQuestions.length) {
      // All questions have been used
      return null;
    }

    int index;
    do {
      index = _random.nextInt(_availableQuestions.length);
    } while (_usedQuestionIndices.contains(index));

    _usedQuestionIndices.add(index);
    return _availableQuestions[index];
  }

  // Reset used questions to start over
  void reset() {
    _usedQuestionIndices.clear();
  }
}
