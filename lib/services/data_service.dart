import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_models.dart';

class QuestionRepository {
  // Map of categories to their corresponding questions
  static final Map<String, List<Question>> _questionsByCategory = {
    'Histoire': _historyQuestions,
    'Géographie': _geographyQuestions,
    'Science': _scienceQuestions,
    'Art & Littérature': _artLiteratureQuestions,
    'Sport': _sportsQuestions,
    'Cinéma': _movieQuestions,
    'Musique': _musicQuestions,
    'Culture Générale': _generalKnowledgeQuestions,
  };

  // Get all available categories
  static List<String> getAllCategories() {
    return _questionsByCategory.keys.toList();
  }

  // Get questions based on selected categories and count per category
  static List<Question> getQuestionsByCategories(
      List<String> categories, int questionsPerCategory) {
    List<Question> selectedQuestions = [];

    for (var category in categories) {
      if (_questionsByCategory.containsKey(category)) {
        var categoryQuestions = _questionsByCategory[category]!;
        categoryQuestions.shuffle();
        selectedQuestions.addAll(categoryQuestions.take(questionsPerCategory));
      }
    }

    selectedQuestions.shuffle();
    return selectedQuestions;
  }

  // History questions
  static final List<Question> _historyQuestions = [
    Question(
      text: 'En quelle année a commencé la Première Guerre mondiale?',
      options: ['1912', '1914', '1916', '1918'],
      correctAnswerIndex: 1,
      category: 'Histoire',
      difficulty: 1,
    ),
    Question(
      text: 'Qui a découvert l\'Amérique en 1492?',
      options: ['Amerigo Vespucci', 'Christophe Colomb', 'Vasco de Gama', 'Ferdinand Magellan'],
      correctAnswerIndex: 1,
      category: 'Histoire',
      difficulty: 1,
    ),
    Question(
      text: 'Qui était le premier président de la République française?',
      options: ['Charles de Gaulle', 'Louis-Napoléon Bonaparte', 'Adolphe Thiers', 'René Coty'],
      correctAnswerIndex: 2,
      category: 'Histoire',
      difficulty: 2,
    ),
    Question(
      text: 'Quel roi de France était connu sous le nom de "Roi Soleil"?',
      options: ['Louis XIV', 'Louis XV', 'Louis XVI', 'Henri IV'],
      correctAnswerIndex: 0,
      category: 'Histoire',
      difficulty: 1,
    ),
    Question(
      text: 'En quelle année la Révolution française a-t-elle commencé?',
      options: ['1769', '1789', '1799', '1809'],
      correctAnswerIndex: 1,
      category: 'Histoire',
      difficulty: 1,
    ),
    Question(
      text: 'Qui était le dirigeant de l\'URSS pendant la majeure partie de la Seconde Guerre mondiale?',
      options: ['Lénine', 'Staline', 'Khrouchtchev', 'Gorbatchev'],
      correctAnswerIndex: 1,
      category: 'Histoire',
      difficulty: 1,
    ),
  ];

  // Geography questions
  static final List<Question> _geographyQuestions = [
    Question(
      text: 'Quelle est la capitale de l\'Australie?',
      options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
      correctAnswerIndex: 2,
      category: 'Géographie',
      difficulty: 2,
    ),
    Question(
      text: 'Quel est le plus long fleuve du monde?',
      options: ['Amazone', 'Nil', 'Yangtsé', 'Mississippi'],
      correctAnswerIndex: 1,
      category: 'Géographie',
      difficulty: 1,
    ),
    Question(
      text: 'Quel pays a la plus grande superficie au monde?',
      options: ['Canada', 'Chine', 'États-Unis', 'Russie'],
      correctAnswerIndex: 3,
      category: 'Géographie',
      difficulty: 1,
    ),
    Question(
      text: 'Quel océan est le plus grand?',
      options: ['Atlantique', 'Indien', 'Arctique', 'Pacifique'],
      correctAnswerIndex: 3,
      category: 'Géographie',
      difficulty: 1,
    ),
    Question(
      text: 'Quel pays a pour capitale Nairobi?',
      options: ['Nigéria', 'Kenya', 'Tanzanie', 'Éthiopie'],
      correctAnswerIndex: 1,
      category: 'Géographie',
      difficulty: 2,
    ),
    Question(
      text: 'Quelle est la chaîne de montagnes la plus longue du monde?',
      options: ['Alpes', 'Himalaya', 'Rocheuses', 'Andes'],
      correctAnswerIndex: 3,
      category: 'Géographie',
      difficulty: 2,
    ),
  ];

  // Science questions
  static final List<Question> _scienceQuestions = [
    Question(
      text: 'Quel est le symbole chimique de l\'or?',
      options: ['O', 'Au', 'Ag', 'Or'],
      correctAnswerIndex: 1,
      category: 'Science',
      difficulty: 1,
    ),
    Question(
      text: 'Quelle planète est connue comme la "planète rouge"?',
      options: ['Jupiter', 'Vénus', 'Mars', 'Saturne'],
      correctAnswerIndex: 2,
      category: 'Science',
      difficulty: 1,
    ),
    Question(
      text: 'Quelle est la formule chimique de l\'eau?',
      options: ['H2O', 'CO2', 'O2', 'H2SO4'],
      correctAnswerIndex: 0,
      category: 'Science',
      difficulty: 1,
    ),
    Question(
      text: 'Quelle est la vitesse de la lumière (approximative)?',
      options: ['300 000 km/s', '150 000 km/s', '500 000 km/s', '1 000 000 km/s'],
      correctAnswerIndex: 0,
      category: 'Science',
      difficulty: 2,
    ),
    Question(
      text: 'Qui a formulé la théorie de la relativité?',
      options: ['Isaac Newton', 'Albert Einstein', 'Niels Bohr', 'Galileo Galilei'],
      correctAnswerIndex: 1,
      category: 'Science',
      difficulty: 1,
    ),
    Question(
      text: 'Quel est l\'os le plus long du corps humain?',
      options: ['Humérus', 'Radius', 'Fémur', 'Tibia'],
      correctAnswerIndex: 2,
      category: 'Science',
      difficulty: 2,
    ),
  ];

  // Art & Literature questions
  static final List<Question> _artLiteratureQuestions = [
    Question(
      text: 'Qui a peint La Joconde?',
      options: ['Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Claude Monet'],
      correctAnswerIndex: 2,
      category: 'Art & Littérature',
      difficulty: 1,
    ),
    Question(
      text: 'Qui a écrit "Les Misérables"?',
      options: ['Victor Hugo', 'Alexandre Dumas', 'Émile Zola', 'Albert Camus'],
      correctAnswerIndex: 0,
      category: 'Art & Littérature',
      difficulty: 1,
    ),
    Question(
      text: 'De quel pays Shakespeare est-il originaire?',
      options: ['France', 'Angleterre', 'Allemagne', 'Italie'],
      correctAnswerIndex: 1,
      category: 'Art & Littérature',
      difficulty: 1,
    ),
    Question(
      text: 'Quel mouvement artistique est associé à Claude Monet?',
      options: ['Cubisme', 'Surréalisme', 'Impressionnisme', 'Renaissance'],
      correctAnswerIndex: 2,
      category: 'Art & Littérature',
      difficulty: 2,
    ),
    Question(
      text: 'Qui a écrit "Le Petit Prince"?',
      options: ['Jules Verne', 'Antoine de Saint-Exupéry', 'Marcel Proust', 'Albert Camus'],
      correctAnswerIndex: 1,
      category: 'Art & Littérature',
      difficulty: 1,
    ),
    Question(
      text: 'Quel peintre est connu pour s\'être coupé l\'oreille?',
      options: ['Vincent van Gogh', 'Salvador Dalí', 'Pablo Picasso', 'Claude Monet'],
      correctAnswerIndex: 0,
      category: 'Art & Littérature',
      difficulty: 1,
    ),
  ];

  // Sports questions
  static final List<Question> _sportsQuestions = [
    Question(
      text: 'Dans quel sport peut-on marquer un "essai"?',
      options: ['Football', 'Rugby', 'Tennis', 'Golf'],
      correctAnswerIndex: 1,
      category: 'Sport',
      difficulty: 1,
    ),
    Question(
      text: 'En quelle année le premier Mondial de football a-t-il eu lieu?',
      options: ['1926', '1930', '1934', '1938'],
      correctAnswerIndex: 1,
      category: 'Sport',
      difficulty: 2,
    ),
    Question(
      text: 'Combien de joueurs y a-t-il dans une équipe de basketball sur le terrain?',
      options: ['4', '5', '6', '7'],
      correctAnswerIndex: 1,
      category: 'Sport',
      difficulty: 1,
    ),
    Question(
      text: 'Quel pays a remporté le plus de Coupes du Monde de football?',
      options: ['Allemagne', 'Brésil', 'Italie', 'Argentine'],
      correctAnswerIndex: 1,
      category: 'Sport',
      difficulty: 1,
    ),
    Question(
      text: 'Dans quel sport utilise-t-on un "shuttlecock"?',
      options: ['Tennis', 'Badminton', 'Squash', 'Ping-pong'],
      correctAnswerIndex: 1,
      category: 'Sport',
      difficulty: 2,
    ),
    Question(
      text: 'Quelle distance parcourt-on dans un marathon?',
      options: ['21.0975 km', '42.195 km', '50 km', '100 km'],
      correctAnswerIndex: 1,
      category: 'Sport',
      difficulty: 1,
    ),
  ];

  // Movies questions
  static final List<Question> _movieQuestions = [
    Question(
      text: 'Qui a réalisé le film "Pulp Fiction"?',
      options: ['Martin Scorsese', 'Quentin Tarantino', 'Steven Spielberg', 'Christopher Nolan'],
      correctAnswerIndex: 1,
      category: 'Cinéma',
      difficulty: 1,
    ),
    Question(
      text: 'Quel acteur joue le rôle principal dans "Forrest Gump"?',
      options: ['Tom Hanks', 'Brad Pitt', 'Leonardo DiCaprio', 'Robert De Niro'],
      correctAnswerIndex: 0,
      category: 'Cinéma',
      difficulty: 1,
    ),
    Question(
      text: 'En quelle année est sorti le premier film Star Wars?',
      options: ['1975', '1977', '1979', '1981'],
      correctAnswerIndex: 1,
      category: 'Cinéma',
      difficulty: 1,
    ),
    Question(
      text: 'Qui joue le personnage d\'Iron Man dans l\'univers cinématographique Marvel?',
      options: ['Chris Evans', 'Chris Hemsworth', 'Robert Downey Jr.', 'Mark Ruffalo'],
      correctAnswerIndex: 2,
      category: 'Cinéma',
      difficulty: 1,
    ),
    Question(
      text: 'Quel est le film ayant remporté le plus d\'Oscars à ce jour?',
      options: ['Titanic', 'Le Seigneur des Anneaux: Le Retour du Roi', 'Ben-Hur', 'Les trois ont le même nombre (11)'],
      correctAnswerIndex: 3,
      category: 'Cinéma',
      difficulty: 3,
    ),
    Question(
      text: 'Qui a réalisé "E.T. l\'extra-terrestre"?',
      options: ['James Cameron', 'George Lucas', 'Steven Spielberg', 'Francis Ford Coppola'],
      correctAnswerIndex: 2,
      category: 'Cinéma',
      difficulty: 1,
    ),
  ];

  // Music questions
  static final List<Question> _musicQuestions = [
    Question(
      text: 'Quel groupe a interprété "Bohemian Rhapsody"?',
      options: ['The Beatles', 'Queen', 'The Rolling Stones', 'Led Zeppelin'],
      correctAnswerIndex: 1,
      category: 'Musique',
      difficulty: 1,
    ),
    Question(
      text: 'Quel est le prénom de la chanteuse Beyoncé?',
      options: ['Beyoncé', 'Beyoncé est son prénom', 'Giselle', 'Knowles'],
      correctAnswerIndex: 1,
      category: 'Musique',
      difficulty: 1,
    ),
    Question(
      text: 'De quel pays le groupe ABBA est-il originaire?',
      options: ['Norvège', 'Danemark', 'Suède', 'Finlande'],
      correctAnswerIndex: 2,
      category: 'Musique',
      difficulty: 1,
    ),
    Question(
      text: 'Quel musicien est connu comme le "King of Pop"?',
      options: ['Elvis Presley', 'Michael Jackson', 'Prince', 'Stevie Wonder'],
      correctAnswerIndex: 1,
      category: 'Musique',
      difficulty: 1,
    ),
    Question(
      text: 'Quel instrument Yo-Yo Ma joue-t-il?',
      options: ['Violon', 'Piano', 'Violoncelle', 'Flûte'],
      correctAnswerIndex: 2,
      category: 'Musique',
      difficulty: 2,
    ),
    Question(
      text: 'Qui a composé "Les Quatre Saisons"?',
      options: ['Mozart', 'Bach', 'Vivaldi', 'Beethoven'],
      correctAnswerIndex: 2,
      category: 'Musique',
      difficulty: 1,
    ),
  ];

  // General Knowledge questions
  static final List<Question> _generalKnowledgeQuestions = [
    Question(
      text: 'Quelle est la monnaie du Japon?',
      options: ['Yuan', 'Won', 'Yen', 'Ringgit'],
      correctAnswerIndex: 2,
      category: 'Culture Générale',
      difficulty: 1,
    ),
    Question(
      text: 'Quel est l\'animal national de l\'Australie?',
      options: ['Kangourou', 'Koala', 'Émeu', 'Ornithorynque'],
      correctAnswerIndex: 0,
      category: 'Culture Générale',
      difficulty: 1,
    ),
    Question(
      text: 'Combien de côtés a un hexagone?',
      options: ['5', '6', '7', '8'],
      correctAnswerIndex: 1,
      category: 'Culture Générale',
      difficulty: 1,
    ),
    Question(
      text: 'Qui a écrit "1984"?',
      options: ['Aldous Huxley', 'George Orwell', 'Ray Bradbury', 'H.G. Wells'],
      correctAnswerIndex: 1,
      category: 'Culture Générale',
      difficulty: 1,
    ),
    Question(
      text: 'Quel est le plus petit pays du monde en termes de superficie?',
      options: ['Monaco', 'Nauru', 'Vatican', 'Saint-Marin'],
      correctAnswerIndex: 2,
      category: 'Culture Générale',
      difficulty: 2,
    ),
    Question(
      text: 'Quelle est la capitale de la Nouvelle-Zélande?',
      options: ['Auckland', 'Wellington', 'Christchurch', 'Hamilton'],
      correctAnswerIndex: 1,
      category: 'Culture Générale',
      difficulty: 2,
    ),
  ];
}

class GameStateManager {
  static const String _highScoreKey = 'highScores';
  static const String _gamesPlayedKey = 'gamesPlayed';
  static const String _lastGameKey = 'lastGame';

  // Save high scores for teams
  static Future<void> saveHighScore(List<Team> teams) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> highScoresList = prefs.getStringList(_highScoreKey) ?? [];
    
    for (var team in teams) {
      highScoresList.add('${team.name}:${team.score}:${team.emoji}');
    }
    
    // Sort by score (descending) and take top 10
    highScoresList.sort((a, b) {
      int scoreA = int.parse(a.split(':')[1]);
      int scoreB = int.parse(b.split(':')[1]);
      return scoreB.compareTo(scoreA);
    });
    
    final List<String> top10 = highScoresList.take(10).toList();
    await prefs.setStringList(_highScoreKey, top10);
  }

  // Get high scores
  static Future<List<Team>> getHighScores() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> highScoresList = prefs.getStringList(_highScoreKey) ?? [];
    
    List<Team> teams = [];
    for (var score in highScoresList) {
      final parts = score.split(':');
      teams.add(Team(
        name: parts[0],
        score: int.parse(parts[1]),
        emoji: parts[2],
      ));
    }
    
    return teams;
  }

  // Increment games played counter
  static Future<void> incrementGamesPlayed() async {
    final prefs = await SharedPreferences.getInstance();
    final int gamesPlayed = prefs.getInt(_gamesPlayedKey) ?? 0;
    await prefs.setInt(_gamesPlayedKey, gamesPlayed + 1);
  }

  // Get games played count
  static Future<int> getGamesPlayed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_gamesPlayedKey) ?? 0;
  }

  // Save last game results
  static Future<void> saveLastGame(List<Team> teams, DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> teamData = [];
    
    for (var team in teams) {
      teamData.add('${team.name}:${team.score}:${team.emoji}');
    }
    
    await prefs.setStringList('${_lastGameKey}_teams', teamData);
    await prefs.setString('${_lastGameKey}_date', date.toIso8601String());
  }

  // Get last game results
  static Future<Map<String, dynamic>> getLastGame() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> teamData = prefs.getStringList('${_lastGameKey}_teams') ?? [];
    final String? dateString = prefs.getString('${_lastGameKey}_date');
    
    if (teamData.isEmpty || dateString == null) {
      return {};
    }
    
    List<Team> teams = [];
    for (var data in teamData) {
      final parts = data.split(':');
      teams.add(Team(
        name: parts[0],
        score: int.parse(parts[1]),
        emoji: parts[2],
      ));
    }
    
    return {
      'teams': teams,
      'date': DateTime.parse(dateString),
    };
  }
}
