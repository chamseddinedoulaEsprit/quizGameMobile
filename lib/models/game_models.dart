class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;
  final String category;
  final int difficulty; // 1-3 (easy to hard)

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    required this.category,
    this.difficulty = 1,
  });
}

class Team {
  String name;
  int score;
  final String emoji;
  List<int> answeredCorrectly = [];

  Team({
    required this.name,
    this.score = 0,
    required this.emoji,
  });

  void addPoints(int points) {
    score += points;
  }

  void resetScore() {
    score = 0;
    answeredCorrectly = [];
  }
}

class GameSettings {
  final List<Team> teams;
  final List<String> selectedCategories;
  final int questionsPerCategory;
  final int maxQuestions;

  GameSettings({
    required this.teams,
    required this.selectedCategories,
    this.questionsPerCategory = 3,
    required this.maxQuestions,
  });
}

class GameSession {
  final GameSettings settings;
  final List<Question> questions;
  int currentQuestionIndex = 0;
  int currentTeamIndex = 0;
  bool isGameOver = false;
  Map<int, Map<int, int>> teamAnswers = {}; // teamIndex -> questionIndex -> answerIndex

  GameSession({
    required this.settings,
    required this.questions,
  }) {
    // Initialize team answers map
    for (int i = 0; i < settings.teams.length; i++) {
      teamAnswers[i] = {};
    }
  }

  Team get currentTeam => settings.teams[currentTeamIndex];
  Question get currentQuestion => questions[currentQuestionIndex];
  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;

  void nextTeam() {
    currentTeamIndex = (currentTeamIndex + 1) % settings.teams.length;
  }

  void nextQuestion() {
    if (!isLastQuestion) {
      currentQuestionIndex++;
    } else {
      isGameOver = true;
    }
  }

  void submitAnswer(int answerIndex) {
    teamAnswers[currentTeamIndex]![currentQuestionIndex] = answerIndex;
    
    if (answerIndex == currentQuestion.correctAnswerIndex) {
      settings.teams[currentTeamIndex].addPoints(currentQuestion.difficulty);
      settings.teams[currentTeamIndex].answeredCorrectly.add(currentQuestionIndex);
    }
  }

  List<Team> getWinners() {
    int highestScore = 0;
    List<Team> winners = [];

    for (var team in settings.teams) {
      if (team.score > highestScore) {
        highestScore = team.score;
        winners = [team];
      } else if (team.score == highestScore) {
        winners.add(team);
      }
    }

    return winners;
  }
}
