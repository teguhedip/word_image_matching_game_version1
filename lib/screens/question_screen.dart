import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_image_matching_game/models/question.dart';
import 'package:word_image_matching_game/providers/game_state.dart';
import 'package:word_image_matching_game/screens/question_widget.dart';

class QuestionScreen extends StatefulWidget {
  final List<Question> questions;

  QuestionScreen({required this.questions}) {
    questions.shuffle();
  }

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<Question> remainingQuestions = [];
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    remainingQuestions = List.from(widget.questions);
    displayNextQuestion();
  }

  void displayNextQuestion() {
    if (remainingQuestions.isEmpty) {
      Navigator.of(context).pushReplacementNamed('/results');
      return;
    }

    setState(() {
      currentQuestionIndex = 0;
    });
  }

  void handleAnswer(String word, bool isCorrect) {
    setState(() {
      remainingQuestions.removeWhere((q) => q.word == word);
    });
    Future.delayed(Duration(seconds: 2), () {
      displayNextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (remainingQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Match Words with Images'),
        ),
        body: Center(child: Text('No more questions')),
      );
    }

    Question currentQuestion = remainingQuestions[currentQuestionIndex];

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: Center(
              child: QuestionWidget(
                question: currentQuestion,
                allQuestions: widget.questions,
                onAnswer: handleAnswer,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<GameState>(
              builder: (context, gameState, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Correct: ${gameState.correctAnswers}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Errors: ${gameState.wrongAttempts}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
