//
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:word_image_matching_game/models/question.dart';
import 'package:word_image_matching_game/providers/game_state.dart';

class GameLogic {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> speakWord(String word) async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.speak(word);
  }

  void initializeWordOptions(Question question, List<Question> allQuestions,
      Function(List<String>) callback) {
    List<String> wordOptions = [
      question.word,
      ...allQuestions
          .where((q) => q.word != question.word)
          .map((q) => q.word)
          .toList()
          .sublist(0, 4)
    ]..shuffle();
    callback(wordOptions);
  }

  void checkAnswer(
      Question question,
      String selectedWord,
      BuildContext context,
      Function(String, bool) onAnswer,
      Function(Color, String, bool, bool) updateState) {
    bool isCorrect = question.word == selectedWord;
    Color color = isCorrect ? Colors.green : Colors.red;

    Provider.of<GameState>(context, listen: false)
        .addAnswer(selectedWord, isCorrect);

    if (isCorrect) {
      Provider.of<GameState>(context, listen: false).incrementCorrectAnswers();
    } else {
      Provider.of<GameState>(context, listen: false).incrementWrongAttempts();
    }

    updateState(color, selectedWord, true, false);

    Future.delayed(Duration(seconds: 1), () {
      updateState(color, selectedWord, true, true);
      onAnswer(question.word, isCorrect);
    });
  }
}
