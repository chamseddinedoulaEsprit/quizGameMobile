import 'package:flutter/material.dart';
import '../models/game_models.dart';
import '../services/data_service.dart';

class GameController extends ChangeNotifier {
  GameSession? _currentGame;
  bool _isLoading = false;
  String? _errorMessage;

  GameSession? get currentGame => _currentGame;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasActiveGame => _currentGame != null;

  // Start a new game with the given settings
  Future<void> startNewGame(GameSettings settings) async {
    _setLoading(true);
    _errorMessage = null;
    
    try {
      // Get questions based on selected categories
      final questions = QuestionRepository.getQuestionsByCategories(
        settings.selectedCategories,
        settings.questionsPerCategory,
      );
      
      // Ensure we have enough questions
      final int totalQuestions = questions.length;
      if (totalQuestions == 0) {
        throw Exception('Aucune question disponible pour les catégories sélectionnées.');
      }
      
      // Create a new game session
      _currentGame = GameSession(
        settings: settings,
        questions: questions,
      );
      
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Submit an answer for the current team
  void submitAnswer(int answerIndex) {
    if (_currentGame == null) return;
    
    _currentGame!.submitAnswer(answerIndex);
    notifyListeners();
  }

  // Move to the next team
  void nextTeam() {
    if (_currentGame == null) return;
    
    _currentGame!.nextTeam();
    notifyListeners();
  }

  // Move to the next question
  void nextQuestion() {
    if (_currentGame == null) return;
    
    _currentGame!.nextQuestion();
    notifyListeners();
  }

  // End the current game and save results
  Future<void> endGame() async {
    if (_currentGame == null) return;
    
    _setLoading(true);
    
    try {
      // Save game results to SharedPreferences
      await GameStateManager.saveHighScore(_currentGame!.settings.teams);
      await GameStateManager.saveLastGame(
        _currentGame!.settings.teams,
        DateTime.now(),
      );
      await GameStateManager.incrementGamesPlayed();
      
      // Mark game as over
      _currentGame!.isGameOver = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Reset the game controller (start over)
  void resetGame() {
    _currentGame = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Helper to set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
