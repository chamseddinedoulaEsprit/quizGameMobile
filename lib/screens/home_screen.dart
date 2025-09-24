import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/common_widgets.dart';
import '../widgets/game_widgets.dart';
import 'game_setup_screen.dart';
import '../theme.dart';
import '../services/data_service.dart';
import '../models/game_models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.withOpacity(0.1),
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Logo and title section
              Expanded(
                flex: 4,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.quiz,
                            size: 80,
                            color: colorScheme.onPrimary,
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .scale(begin: const Offset(0.6, 0.6)),
                        const SizedBox(height: 24),
                        Text(
                          'QuizOff',
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ).animate().fadeIn(duration: 800.ms),
                        const SizedBox(height: 8),
                        Text(
                          'Le jeu de quiz par \u00e9quipes',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 1000.ms),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Stats section
              FutureBuilder<int>(
                future: GameStateManager.getGamesPlayed(),
                builder: (context, snapshot) {
                  final gamesPlayed = snapshot.data ?? 0;
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                '$gamesPlayed',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                              Text(
                                'Parties jou\u00e9es',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(width: 32),
                          Column(
                            children: [
                              Text(
                                '${QuestionRepository.getAllCategories().length}',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.secondary,
                                ),
                              ),
                              Text(
                                'Cat\u00e9gories',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(duration: 1200.ms);
                },
              ),
              
              // Buttons section
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: 'Nouvelle Partie',
                        icon: Icons.play_arrow,
                        isExpanded: true,
                        height: 56,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GameSetupScreen(),
                            ),
                          );
                        },
                      ).animate().fadeIn(duration: 1400.ms),
                      const SizedBox(height: 16),
                      FutureBuilder<Map<String, dynamic>>(
                        future: GameStateManager.getLastGame(),
                        builder: (context, snapshot) {
                          final hasLastGame = snapshot.data != null && snapshot.data!.isNotEmpty;
                          
                          return CustomButton(
                            text: 'Derniers R\u00e9sultats',
                            icon: Icons.history,
                            isPrimary: false,
                            isExpanded: true,
                            onPressed: hasLastGame 
                              ? () => _showLastGameResults(context, snapshot.data!)
                              : null,
                          ).animate().fadeIn(duration: 1600.ms);
                        },
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'D\u00e9fiez vos amis dans des duels de connaissances !',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(duration: 1800.ms),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showLastGameResults(BuildContext context, Map<String, dynamic> lastGame) {
    final List<Team> teams = (lastGame['teams'] as List).cast<Team>();
    final DateTime date = lastGame['date'] as DateTime;
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'R\u00e9sultats du ${date.day}/${date.month}/${date.year}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              ScoreBoard(teams: teams, showWinners: true),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Fermer',
                onPressed: () => Navigator.pop(context),
                isPrimary: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}