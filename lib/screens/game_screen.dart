import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../logic/game_controller.dart';
import '../models/game_models.dart';
import '../widgets/game_widgets.dart';
import '../widgets/common_widgets.dart';
import 'home_screen.dart';
import '../theme.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int? _selectedAnswerIndex;
  bool _showResult = false;
  bool _showConfetti = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playCorrectSound() {
    // This would play a sound from your assets
    // _audioPlayer.play(AssetSource('sounds/correct.mp3'));
  }

  void _playWrongSound() {
    // This would play a sound from your assets
    // _audioPlayer.play(AssetSource('sounds/wrong.mp3'));
  }

  void _selectAnswer(int index) {
    setState(() {
      _selectedAnswerIndex = index;
    });
  }

  void _submitAnswer(GameController gameController) {
    if (_selectedAnswerIndex == null) return;

    final currentGame = gameController.currentGame!;
    final isCorrect = _selectedAnswerIndex == currentGame.currentQuestion.correctAnswerIndex;

    // Play sound based on correct/incorrect answer
    if (isCorrect) {
      _playCorrectSound();
    } else {
      _playWrongSound();
    }

    // Submit answer to game controller
    gameController.submitAnswer(_selectedAnswerIndex!);

    setState(() {
      _showResult = true;
    });
  }

  void _nextQuestion(GameController gameController) {
    final currentGame = gameController.currentGame!;
    
    if (currentGame.isLastQuestion) {
      gameController.endGame();
      setState(() {
        _showConfetti = true;
      });
    } else {
      setState(() {
        _selectedAnswerIndex = null;
        _showResult = false;
      });
      gameController.nextQuestion();
      gameController.nextTeam();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (context, gameController, child) {
        if (!gameController.hasActiveGame) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text('Chargement du jeu...', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          );
        }

        final currentGame = gameController.currentGame!;
        final currentTeam = currentGame.currentTeam;
        final currentQuestion = currentGame.currentQuestion;
        final questionNumber = currentGame.currentQuestionIndex + 1;
        final totalQuestions = currentGame.questions.length;
        
        if (currentGame.isGameOver) {
          return _buildGameOverScreen(context, currentGame);
        }

        return ConfettiOverlay(
          show: _showConfetti,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Question $questionNumber/$totalQuestions'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    _showQuitGameDialog(context, gameController);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Team info
                  TeamCard(
                    team: currentTeam,
                    isActive: true,
                  ).animate().fadeIn(duration: 400.ms).move(begin: const Offset(0, -20), curve: Curves.easeOutQuad),
                  const SizedBox(height: 20),
                  
                  // Question card
                  Expanded(
                    child: QuestionCard(
                      question: currentQuestion,
                      onAnswerSelected: _showResult ? (_) {} : _selectAnswer,
                      selectedAnswerIndex: _selectedAnswerIndex,
                      showCorrectAnswer: _showResult,
                    ),
                  ),
                  
                  // Action buttons
                  const SizedBox(height: 20),
                  _showResult
                      ? CustomButton(
                          text: currentGame.isLastQuestion 
                              ? 'Terminer le jeu' 
                              : 'Question suivante',
                          icon: currentGame.isLastQuestion 
                              ? Icons.emoji_events 
                              : Icons.navigate_next,
                          isExpanded: true,
                          onPressed: () => _nextQuestion(gameController),
                        ).animate().fadeIn(duration: 400.ms).move(begin: const Offset(0, 20), curve: Curves.easeOutQuad)
                      : CustomButton(
                          text: 'Valider la r\u00e9ponse',
                          icon: Icons.check_circle,
                          isExpanded: true,
                          onPressed: _selectedAnswerIndex != null
                              ? () => _submitAnswer(gameController)
                              : null,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGameOverScreen(BuildContext context, GameSession gameSession) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return ConfettiOverlay(
      show: true,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Partie termin\u00e9e!',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ).animate().fadeIn(duration: 500.ms).scale(),
                const SizedBox(height: 40),
                
                Expanded(
                  child: ScoreBoard(
                    teams: gameSession.settings.teams,
                    showWinners: true,
                  ),
                ),
                
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Nouvelle partie',
                  icon: Icons.replay,
                  isExpanded: true,
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showQuitGameDialog(BuildContext context, GameController gameController) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 50,
                color: colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Quitter la partie?',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Votre progression sera perdue.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Annuler',
                      isPrimary: false,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Quitter',
                      isPrimary: true,
                      onPressed: () {
                        gameController.resetGame();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}