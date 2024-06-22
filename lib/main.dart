import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_image_matching_game/models/question.dart';
import 'package:word_image_matching_game/providers/game_state.dart';
import 'package:word_image_matching_game/screens/question_screen.dart';
import 'package:word_image_matching_game/screens/result_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Word Image Matching Game',
        initialRoute: '/questions',
        routes: {
          '/questions': (context) =>
              QuestionScreen(questions: QuestionGenerator.generateQuestions()),
          '/results': (context) => ResultScreen(),
        },
      ),
    );
  }
}

class QuestionGenerator {
  static List<Question> generateQuestions() {
    return [
      // Question(word: 'apples', imagePath: 'assets/apples.png'),
      // Question(word: 'banana', imagePath: 'assets/banana.png'),
      // Question(word: 'key', imagePath: 'assets/key.png'),
      // Question(word: 'dog', imagePath: 'assets/dog.png'),
      // Add more questions as needed

      Question(word: 'banana', imagePath: 'assets/banana.png'),
      Question(word: 'bear', imagePath: 'assets/bear.png'),
      Question(word: 'key', imagePath: 'assets/key.png'),
      Question(word: 'dog', imagePath: 'assets/dog.png'),
      Question(word: 'box', imagePath: 'assets/box.png'),
      Question(word: 'bird', imagePath: 'assets/bird.png'),
      Question(word: 'apples', imagePath: 'assets/apples.png'),
      Question(word: 'carrot', imagePath: 'assets/carrot.png'),
      Question(word: 'fruit', imagePath: 'assets/fruit.png'),
      Question(word: 'hand', imagePath: 'assets/hand.png'),
      Question(word: 'onion', imagePath: 'assets/onion.png'),
      Question(word: 'orange', imagePath: 'assets/orange.png'),
      Question(word: 'pen', imagePath: 'assets/pen.png'),
      Question(word: 'phone', imagePath: 'assets/phone.png'),
      Question(word: 'pineapple', imagePath: 'assets/pineapple.png'),
      Question(word: 'pomegranate', imagePath: 'assets/pomegranate.png'),
      Question(word: 'strawberries', imagePath: 'assets/strawberries.png'),
      Question(word: 'train', imagePath: 'assets/train.png'),
    ];
  }
}







//  another  logic     _22222222222222222222222----------

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => GameState(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Word Image Matching Game',
//         initialRoute: '/questions',
//         routes: {
//           '/questions': (context) =>
//               QuestionScreen(questions: QuestionGenerator.generateQuestions()),
//           '/results': (context) => ResultScreen(),
//         },
//       ),
//     );
//   }
// }

// class Question {
//   final String word;
//   final String imagePath;

//   Question({required this.word, required this.imagePath});
// }

// class GameState with ChangeNotifier {
//   int _correctAnswers = 0;
//   int _wrongAttempts = 0;
//   final List<Map<String, dynamic>> _answers = [];
//   List<Question> _allQuestions = [];

//   int get correctAnswers => _correctAnswers;
//   int get wrongAttempts => _wrongAttempts;
//   List<Map<String, dynamic>> get answers => _answers;
//   List<Question> get allQuestions => _allQuestions;

//   void incrementCorrectAnswers() {
//     _correctAnswers++;
//     notifyListeners();
//   }

//   void incrementWrongAttempts() {
//     _wrongAttempts++;
//     notifyListeners();
//   }

//   void addAnswer(String word, bool isCorrect) {
//     _answers.add({'word': word, 'isCorrect': isCorrect});
//     notifyListeners();
//   }

//   void setAllQuestions(List<Question> questions) {
//     _allQuestions = questions;
//     notifyListeners();
//   }

//   void resetGame() {
//     _correctAnswers = 0;
//     _wrongAttempts = 0;
//     _answers.clear();
//     _allQuestions.clear();
//     notifyListeners();
//   }
// }

// class QuestionScreen extends StatefulWidget {
//   final List<Question> questions;

//   QuestionScreen({required this.questions}) {
//     questions.shuffle();
//   }

//   @override
//   State<QuestionScreen> createState() => _QuestionScreenState();
// }

// class _QuestionScreenState extends State<QuestionScreen> {
//   List<Question> remainingQuestions = [];
//   int currentQuestionIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     remainingQuestions = List.from(widget.questions);
//     displayNextQuestion();
//   }

//   void displayNextQuestion() {
//     if (remainingQuestions.isEmpty) {
//       Navigator.of(context).pushReplacementNamed('/results');
//       return;
//     }

//     setState(() {
//       currentQuestionIndex = 0;
//     });
//   }

//   void handleAnswer(String word, bool isCorrect) async {
//     setState(() {
//       remainingQuestions.removeWhere((q) => q.word == word);
//     });

//     final gameLogic = GameLogic();
//     // await gameLogic.showAnswerDialog(context, isCorrect);

//     displayNextQuestion();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (remainingQuestions.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Match Words with Images'),
//         ),
//         body: Center(child: Text('No more questions')),
//       );
//     }

//     Question currentQuestion = remainingQuestions[currentQuestionIndex];

//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 20),
//           Expanded(
//             child: Center(
//               child: QuestionWidget(
//                 question: currentQuestion,
//                 allQuestions: widget.questions,
//                 onAnswer: handleAnswer,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Consumer<GameState>(
//               builder: (context, gameState, child) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       'Correct: ${gameState.correctAnswers}',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                     Text(
//                       'Errors: ${gameState.wrongAttempts}',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class QuestionWidget extends StatelessWidget {
//   final Question question;
//   final List<Question> allQuestions;
//   final Function(String, bool) onAnswer;

//   QuestionWidget({
//     required this.question,
//     required this.allQuestions,
//     required this.onAnswer,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amber.shade100.withOpacity(0.8),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Stack(
//           children: [
//             Positioned(
//               top: 15,
//               left: 20,
//               right: 20,
//               child: Card(
//                 elevation: 10,
//                 margin: EdgeInsets.all(5),
//                 color: Colors.lightBlue,
//                 child: Container(
//                   height: 200,
//                   width: double.maxFinite,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Image.asset(question.imagePath),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 250,
//               left: 20,
//               right: 20,
//               child: _buildOptionsDialog(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOptionsDialog(BuildContext context) {
//     final gameLogic = GameLogic();
//     List<String> wordOptions =
//         gameLogic.generateWordOptions(question, allQuestions);

//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Colors.white,
//             Colors.lightBlue.shade100,
//           ],
//         ),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.lightBlue, width: 2),
//       ),
//       padding: EdgeInsets.all(10),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Center(
//             child: Text(
//               'Select the correct word for the image',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(height: 10),
//           Column(
//             children: wordOptions.map((word) {
//               return ListTile(
//                 title: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black,
//                     backgroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     bool isCorrect = word == question.word;
//                     gameLogic.handleAnswer(
//                         question, word, context, onAnswer, isCorrect);
//                   },
//                   child: Text(word),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ResultScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Results'),
//       ),
//       body: Consumer<GameState>(
//         builder: (context, gameState, child) {
//           final totalAttempts =
//               gameState.correctAnswers + gameState.wrongAttempts;
//           final percentage = totalAttempts > 0
//               ? (gameState.correctAnswers / totalAttempts) * 100
//               : 0;

//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Summary',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     DataTable(
//                       columnSpacing: 20,
//                       headingRowHeight: 60,
//                       dataRowHeight: 60,
//                       border: TableBorder.all(color: Colors.green, width: 2),
//                       columns: [
//                         DataColumn(
//                           label: Text(
//                             'Metric',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         DataColumn(
//                           label: Text(
//                             'Value',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                       rows: [
//                         DataRow(cells: [
//                           DataCell(Text(
//                             'Correct Answers',
//                             style: TextStyle(fontSize: 16),
//                           )),
//                           DataCell(Text(
//                             '${gameState.correctAnswers}',
//                             style: TextStyle(fontSize: 16),
//                           )),
//                         ]),
//                         DataRow(cells: [
//                           DataCell(Text(
//                             'Wrong Attempts',
//                             style: TextStyle(fontSize: 16),
//                           )),
//                           DataCell(Text(
//                             '${gameState.wrongAttempts}',
//                             style: TextStyle(fontSize: 16),
//                           )),
//                         ]),
//                         DataRow(cells: [
//                           DataCell(Text(
//                             'Accuracy',
//                             style: TextStyle(fontSize: 16),
//                           )),
//                           DataCell(Text(
//                             '${percentage.toStringAsFixed(2)}%',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           )),
//                         ]),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         gameState.resetGame();
//                         Navigator.of(context)
//                             .pushReplacementNamed('/questions');
//                       },
//                       child: Text('Restart Game'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class GameLogic {
//   final FlutterTts flutterTts = FlutterTts();

//   List<String> generateWordOptions(
//       Question question, List<Question> allQuestions) {
//     List<String> options = [question.word];
//     // Retrieve all words from the list of questions and ensure uniqueness
//     List<String> allWords = allQuestions.map((q) => q.word).toList();
//     allWords.shuffle(); // Shuffle the words to randomize the options
//     for (String randomWord in allWords) {
//       speakWord(question.word);
//       if (options.length >= 4) break;
//       if (!options.contains(randomWord)) {
//         options.add(randomWord);
//       }
//     }
//     options
//         .shuffle(); // Shuffle again to ensure the correct answer is not always at the first position
//     return options;
//   }

//   Future<void> speakWord(String word) async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setPitch(1);
//     await flutterTts.speak(word);
//   }

//   void handleAnswer(
//     Question question,
//     String selectedWord,
//     BuildContext context,
//     Function(String, bool) onAnswer,
//     bool isCorrect,
//   ) {
//     final gameState = Provider.of<GameState>(context, listen: false);

//     if (isCorrect) {
//       gameState.incrementCorrectAnswers();
//       onAnswer(question.word, true);
//       // showAnswerDialog(context, isCorrect);
//     } else {
//       gameState.incrementWrongAttempts();
//       onAnswer(question.word, false);
//       // showAnswerDialog(context, isCorrect);
//     }
//   }

//   Future<void> showAnswerDialog(BuildContext context, bool isCorrect) async {
//     return showDialog(
//       context: context,
//       builder: (context) => _buildAnswerDialog(
//         context,
//         isCorrect ? 'Correct!' : 'Try Again!',
//         isCorrect ? Colors.green : Colors.red,
//         isCorrect ? Icons.check : Icons.close,
//         isCorrect,
//       ),
//     );
//   }

//   AlertDialog _buildAnswerDialog(BuildContext context, String title,
//       Color color, IconData icon, bool isCorrect) {
//     return AlertDialog(
//       backgroundColor: Colors.amber.shade100.withOpacity(0.8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(color: Colors.lightBlue, width: 2),
//       ),
//       title: Center(
//         child: Icon(
//           icon,
//           size: 50,
//           color: color,
//         ),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Center(
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           Center(
//             child: Text(
//               isCorrect
//                   ? 'Good job! You got the correct answer.'
//                   : 'Oops! That was not the correct answer. Please try again.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         Center(
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.white,
//               backgroundColor: Colors.lightBlue,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('OK'),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class QuestionGenerator {
//   static List<Question> generateQuestions() {
//     return [
//       Question(word: 'banana', imagePath: 'assets/banana.png'),
//       Question(word: 'bear', imagePath: 'assets/bear.png'),
//       Question(word: 'key', imagePath: 'assets/key.png'),
//       Question(word: 'dog', imagePath: 'assets/dog.png'),
//       Question(word: 'box', imagePath: 'assets/box.png'),
//     ];
//   }
// }













// class ResultScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Game Results'),
//       ),
//       body: Consumer<GameState>(
//         builder: (context, gameState, child) {
//           return Column(
//             children: [
//               SizedBox(height: 20),
//               Text(
//                 'Results',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Correct Answers: ${gameState.correctAnswers}',
//                 style: TextStyle(fontSize: 20, color: Colors.green),
//               ),
//               Text(
//                 'Wrong Attempts: ${gameState.wrongAttempts}',
//                 style: TextStyle(fontSize: 20, color: Colors.red),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   gameState.resetGame();
//                   Navigator.of(context).pushReplacementNamed('/questions');
//                 },
//                 child: Text('Play Again'),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }