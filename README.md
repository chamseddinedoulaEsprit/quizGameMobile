# QuizOff 🎯

Une application mobile de quiz multijoueur développée avec Flutter, parfaite pour organiser des compétitions amusantes entre amis, en famille ou en équipe.

## 🚀 Fonctionnalités

### 🎮 Jeu Multijoueur
- **Équipes personnalisables** : Créez jusqu'à plusieurs équipes avec noms et emojis
- **Système de points** : Scoring basé sur la difficulté des questions
- **Tour par tour** : Chaque équipe répond à son tour pour un gameplay équitable
- **Classement en temps réel** : Suivez les scores pendant toute la partie

### 📚 Contenu Éducatif
- **Catégories variées** : Questions couvrant différents domaines de connaissance
- **Niveaux de difficulté** : Questions faciles, moyennes et difficiles (1-3 points)
- **Questions aléatoires** : Génération automatique pour des parties toujours différentes
- **Base de données riche** : Large collection de questions intégrées

### 🎨 Interface Moderne
- **Design élégant** : Interface moderne avec animations fluides
- **Mode sombre/clair** : S'adapte automatiquement aux préférences système
- **Responsive** : Optimisé pour tous les types d'écrans
- **Feedback visuel** : Animations et transitions pour une meilleure expérience

## 📱 Captures d'écran

L'application comprend plusieurs écrans principaux :
- **Écran d'accueil** : Interface principale avec logo et navigation
- **Configuration du jeu** : Création des équipes et sélection des catégories  
- **Écran de jeu** : Interface de quiz avec questions et options
- **Résultats** : Affichage des scores finaux et des gagnants

## 🛠️ Installation et Configuration

### Prérequis
- Flutter SDK (>=3.0.0)
- Dart SDK
- Un éditeur de code (VS Code, Android Studio, etc.)

### Installation
1. Clonez le repository :
```bash
git clone <votre-repository>
cd quizoff
```

2. Installez les dépendances :
```bash
flutter pub get
```

3. Lancez l'application :
```bash
flutter run
```

## 📦 Dépendances Principales

- **flutter_animate** : Animations fluides et modernes
- **provider** : Gestion d'état réactive
- **fl_chart** : Graphiques et visualisations de données
- **google_fonts** : Typographies personnalisées
- **shared_preferences** : Stockage local des données
- **audioplayers** : Effets sonores du jeu

## 🏗️ Architecture

### Structure du Projet
```
lib/
├── main.dart                 # Point d'entrée de l'application
├── theme.dart               # Thèmes clair et sombre
├── models/
│   └── game_models.dart     # Modèles de données (Question, Team, GameSession)
├── screens/
│   ├── home_screen.dart     # Écran d'accueil
│   ├── game_setup_screen.dart # Configuration du jeu
│   └── game_screen.dart     # Écran de jeu principal
├── widgets/
│   ├── common_widgets.dart  # Widgets réutilisables
│   └── game_widgets.dart    # Widgets spécifiques au jeu
├── logic/
│   ├── game_controller.dart # Contrôleur principal du jeu
│   └── question_generator.dart # Génération des questions
└── services/
    └── data_service.dart    # Service de données et questions
```

### Modèles de Données

#### Question
```dart
class Question {
  final String text;              // Texte de la question
  final List<String> options;     // Options de réponse
  final int correctAnswerIndex;   // Index de la bonne réponse
  final String category;          // Catégorie de la question
  final int difficulty;           // Difficulté (1-3)
}
```

#### Team
```dart
class Team {
  String name;                    // Nom de l'équipe
  int score;                      // Score actuel
  final String emoji;             // Emoji représentatif
  List<int> answeredCorrectly;    // Questions réussies
}
```

#### GameSession
```dart
class GameSession {
  final GameSettings settings;    // Configuration du jeu
  final List<Question> questions; // Questions de la partie
  int currentQuestionIndex;       // Question actuelle
  int currentTeamIndex;          // Équipe qui joue
  bool isGameOver;               // État de fin de partie
}
```

## 🎯 Comment Jouer

1. **Démarrage** : Lancez l'application depuis l'écran d'accueil
2. **Configuration** : 
   - Créez vos équipes (nom + emoji)
   - Sélectionnez les catégories de questions
   - Définissez le nombre de questions
3. **Partie** :
   - Chaque équipe répond à tour de rôle
   - Les points sont attribués selon la difficulté
   - Suivez les scores en temps réel
4. **Résultats** : Découvrez l'équipe gagnante à la fin !

## 🎨 Personnalisation

### Thèmes
L'application supporte automatiquement les modes clair et sombre selon les préférences système.

### Ajout de Questions
Pour ajouter de nouvelles questions, modifiez le fichier `lib/services/data_service.dart` :

```dart
Question(
  text: "Votre question ?",
  options: ["Option A", "Option B", "Option C", "Option D"],
  correctAnswerIndex: 0, // Index de la bonne réponse
  category: "Votre Catégorie",
  difficulty: 2, // 1-3
)
```

## 🚀 Déploiement

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Forkez le projet
2. Créez une branche pour votre feature (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Pushez vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## 📞 Support

Pour toute question ou suggestion, n'hésitez pas à ouvrir une issue sur GitHub.

---

**QuizOff** - Transformez vos connaissances en compétition ! 🏆
