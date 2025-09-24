import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../widgets/common_widgets.dart';
import '../logic/game_controller.dart';
import '../models/game_models.dart';
import '../services/data_service.dart';
import 'game_screen.dart';
import '../theme.dart';

class GameSetupScreen extends StatefulWidget {
  const GameSetupScreen({super.key});

  @override
  State<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends State<GameSetupScreen> {
  final List<Team> _teams = [
    Team(name: 'Équipe 1', emoji: '🦊'),
    Team(name: 'Équipe 2', emoji: '🦁'),
  ];

  final _emojiOptions = ['🦊', '🦁', '🐼', '🐵', '🦄', '🐲', '🐬', '🦉', '🦥', '🐙', '🐢', '🦈'];

  final _categoryList = QuestionRepository.getAllCategories();
  final List<String> _selectedCategories = [];
  int _questionsPerCategory = 3;
  int _maxQuestions = 15;

  final TextEditingController _teamNameController = TextEditingController();
  String _selectedEmoji = '🦊';

  @override
  void initState() {
    super.initState();
    // Select the first two categories by default
    if (_categoryList.length >= 2) {
      _selectedCategories.addAll(_categoryList.take(2));
    }
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  void _addTeam() {
    // Don't add if no name provided or already 6 teams
    if (_teamNameController.text.trim().isEmpty || _teams.length >= 6) return;

    setState(() {
      _teams.add(
        Team(
          name: _teamNameController.text.trim(),
          emoji: _selectedEmoji,
        ),
      );
      // Reset for next team
      _teamNameController.clear();
      _selectedEmoji = _emojiOptions.firstWhere(
        (emoji) => !_teams.any((team) => team.emoji == emoji),
        orElse: () => _emojiOptions.first,
      );
    });
  }

  void _removeTeam(int index) {
    if (_teams.length <= 2) return; // Keep at least 2 teams
    setState(() {
      _teams.removeAt(index);
    });
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        // Don't remove if it's the last category
        if (_selectedCategories.length > 1) {
          _selectedCategories.remove(category);
        }
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _startGame() {
    if (_teams.length < 2 || _selectedCategories.isEmpty) return;

    // Calculate maximum questions based on category selection and questions per category
    final totalAvailableQuestions = _selectedCategories.length * _questionsPerCategory;
    final actualMaxQuestions = totalAvailableQuestions > _maxQuestions 
        ? _maxQuestions 
        : totalAvailableQuestions;

    // Create game settings
    final gameSettings = GameSettings(
      teams: List.from(_teams), // Create a copy of the teams list
      selectedCategories: _selectedCategories,
      questionsPerCategory: _questionsPerCategory,
      maxQuestions: actualMaxQuestions,
    );

    // Get the game controller and start a new game
    final gameController = Provider.of<GameController>(context, listen: false);
    gameController.startNewGame(gameSettings).then((_) {
      if (gameController.errorMessage == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const GameScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuration de la partie'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Teams section
              _buildSectionTitle(context, 'Équipes', Icons.people),
              const SizedBox(height: 16),
              ...List.generate(
                _teams.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _buildTeamRow(index),
                ),
              ),
              const SizedBox(height: 16),
              if (_teams.length < 6)
                _buildAddTeamSection(),
              const SizedBox(height: 24),

              // Categories section
              _buildSectionTitle(context, 'Catégories', Icons.category),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 12,
                children: _categoryList.map((category) {
                  return CategoryChip(
                    label: category,
                    isSelected: _selectedCategories.contains(category),
                    onTap: () => _toggleCategory(category),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Questions per category slider
              _buildSectionTitle(
                  context, 'Questions par catégorie', Icons.help),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _questionsPerCategory.toDouble(),
                      min: 1,
                      max: 6,
                      divisions: 5,
                      label: _questionsPerCategory.toString(),
                      onChanged: (value) {
                        setState(() {
                          _questionsPerCategory = value.toInt();
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _questionsPerCategory.toString(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Total approximatif: ${_selectedCategories.length * _questionsPerCategory} questions',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 40),

              // Start game button
              CustomButton(
                text: 'Commencer la partie',
                icon: Icons.play_arrow,
                isExpanded: true,
                height: 56,
                onPressed: _startGame,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildTeamRow(int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CustomCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          TeamAvatar(emoji: _teams[index].emoji, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _teams[index].name,
              style: theme.textTheme.titleMedium,
            ),
          ),
          if (_teams.length > 2) // Only show remove button if more than minimum teams
            IconButton(
              icon: Icon(Icons.delete, color: colorScheme.error),
              onPressed: () => _removeTeam(index),
            ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: (100 * index).ms);
  }

  Widget _buildAddTeamSection() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ajouter une équipe',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: _showEmojiPicker,
                child: TeamAvatar(emoji: _selectedEmoji, size: 40),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _teamNameController,
                  decoration: InputDecoration(
                    hintText: 'Nom de l\'équipe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.add_circle, color: colorScheme.primary),
                onPressed: _addTeam,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.95, 0.95));
  }

  void _showEmojiPicker() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Filter out emojis already used by teams
    final availableEmojis = _emojiOptions
        .where((emoji) => !_teams.any((team) => team.emoji == emoji))
        .toList();

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
                'Choisir un emoji',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: availableEmojis.map((emoji) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedEmoji = emoji;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}