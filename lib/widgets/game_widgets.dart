import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/game_models.dart';
import 'common_widgets.dart';
import '../theme.dart';

class TeamCard extends StatelessWidget {
  final Team team;
  final bool isActive;
  final VoidCallback? onTap;

  const TeamCard({
    super.key,
    required this.team,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CustomCard(
      onTap: onTap,
      backgroundColor: isActive ? colorScheme.primary.withOpacity(0.1) : null,
      padding: const EdgeInsets.all(12),
      borderRadius: 12,
      hasShadow: isActive,
      child: Row(
        children: [
          TeamAvatar(
            emoji: team.emoji,
            size: 45,
            backgroundColor: isActive ? colorScheme.primary.withOpacity(0.3) : colorScheme.primary.withOpacity(0.1),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isActive ? colorScheme.primary : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${team.score} points',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isActive ? colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Joue',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().fadeIn(duration: 300.ms).scale(),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final Question question;
  final Function(int) onAnswerSelected;
  final int? selectedAnswerIndex;
  final bool showCorrectAnswer;

  const QuestionCard({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    this.selectedAnswerIndex,
    this.showCorrectAnswer = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CustomCard(
      padding: const EdgeInsets.all(20),
      hasShadow: true,
      backgroundColor: colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  question.category,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  question.difficulty,
                  (index) => Icon(
                    Icons.star,
                    size: 16,
                    color: colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            question.text,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 400.ms).slide(begin: const Offset(0, 0.1), end: const Offset(0, 0)),
          const SizedBox(height: 24),
          ...List.generate(
            question.options.length,
            (index) => _buildAnswerOption(context, index),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(BuildContext context, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final isSelected = selectedAnswerIndex == index;
    final isCorrect = question.correctAnswerIndex == index;
    
    Color backgroundColor;
    Color textColor;
    
    if (showCorrectAnswer) {
      if (isCorrect) {
        backgroundColor = Colors.green.withOpacity(0.2);
        textColor = Colors.green;
      } else if (isSelected && !isCorrect) {
        backgroundColor = Colors.red.withOpacity(0.2);
        textColor = Colors.red;
      } else {
        backgroundColor = colorScheme.surface;
        textColor = colorScheme.onSurface;
      }
    } else {
      backgroundColor = isSelected ? colorScheme.primary.withOpacity(0.2) : colorScheme.surface;
      textColor = isSelected ? colorScheme.primary : colorScheme.onSurface;
    }

    return GestureDetector(
      onTap: showCorrectAnswer ? null : () => onAnswerSelected(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline.withOpacity(0.5),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? colorScheme.primary : colorScheme.surface,
                border: Border.all(
                  color: isSelected ? colorScheme.primary : colorScheme.outline,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index), // A, B, C, D...
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                question.options[index],
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (showCorrectAnswer && isCorrect)
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 24,
              ),
            if (showCorrectAnswer && isSelected && !isCorrect)
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 24,
              ),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms, delay: (100 * index).ms).slide(begin: const Offset(0.05, 0), end: const Offset(0, 0)),
    );
  }
}

class ScoreBoard extends StatelessWidget {
  final List<Team> teams;
  final bool showWinners;

  const ScoreBoard({
    super.key,
    required this.teams,
    this.showWinners = false,
  });

  @override
  Widget build(BuildContext context) {
    // Sort teams by score (descending)
    final sortedTeams = List<Team>.from(teams)
      ..sort((a, b) => b.score.compareTo(a.score));

    // Check if there are multiple teams with the highest score (tie)
    final highestScore = sortedTeams.isNotEmpty ? sortedTeams.first.score : 0;
    final winners = sortedTeams.where((team) => team.score == highestScore).toList();
    final bool isTie = winners.length > 1;

    return Column(
      children: [
        if (showWinners && sortedTeams.isNotEmpty) ...[
          Text(
            isTie ? 'Match nul !' : '${winners.first.name} a gagné !',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(begin: const Offset(0.8, 0.8), duration: 600.ms),
          const SizedBox(height: 8),
          Text(
            isTie
                ? 'Score: $highestScore points'
                : 'Avec $highestScore points',
            style: Theme.of(context).textTheme.titleMedium,
          ).animate().fadeIn(duration: 800.ms),
          const SizedBox(height: 24),
        ],
        ...List.generate(
          sortedTeams.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildTeamScoreRow(
              context,
              sortedTeams[index],
              index: index,
              isWinner: showWinners && sortedTeams[index].score == highestScore,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamScoreRow(BuildContext context, Team team, {required int index, required bool isWinner}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CustomCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      backgroundColor: isWinner ? colorScheme.primary.withOpacity(0.1) : null,
      borderRadius: 12,
      hasShadow: isWinner,
      isAnimated: true,
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isWinner ? colorScheme.primary : colorScheme.surface,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isWinner ? colorScheme.onPrimary : colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          TeamAvatar(
            emoji: team.emoji,
            size: 36,
            backgroundColor: isWinner
                ? colorScheme.primary.withOpacity(0.3)
                : colorScheme.primary.withOpacity(0.1),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              team.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
                color: isWinner ? colorScheme.primary : null,
              ),
            ),
          ),
          Text(
            '${team.score}',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isWinner ? colorScheme.primary : null,
            ),
          ),
          if (isWinner)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.emoji_events,
                color: colorScheme.tertiary,
                size: 24,
              ),
            ).animate().fadeIn(duration: 500.ms).shake(),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: (100 * index).ms);
  }
}
