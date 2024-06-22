//

import 'package:flutter/material.dart';
import 'package:word_image_matching_game/game_logic.dart';
import 'package:word_image_matching_game/models/question.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final List<Question> allQuestions;
  final Function(String, bool) onAnswer;

  QuestionWidget({
    required this.question,
    required this.allQuestions,
    required this.onAnswer,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Color? _color;
  bool _isLocked = false;
  bool _showCard = false;
  bool _showDialog = false;
  bool _hideDialog = false;
  bool _canInteract = true;
  String? selectedWord;
  late List<String> wordOptions;
  final GameLogic _gameLogic = GameLogic();

  @override
  void initState() {
    super.initState();
    _initializeImageOptions();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _showCard = true;
        _gameLogic.speakWord(widget.question.word);
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _showDialog = true;
        });
      });
    });
  }

  void _initializeImageOptions() {
    _gameLogic.initializeWordOptions(widget.question, widget.allQuestions,
        (options) {
      setState(() {
        wordOptions = options.take(3).toList(); // Select 3 random options
        if (!wordOptions.contains(widget.question.word)) {
          wordOptions.add(
              widget.question.word); // Ensure the correct answer is included
          wordOptions
              .shuffle(); // Shuffle to randomize the position of the correct answer
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant QuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _initializeImageOptions();

      setState(() {
        _color = null; // Reset color to default
        _showCard = false;
        _showDialog = false;
        _hideDialog = false;
        _canInteract = true;
        selectedWord = null;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _showCard = true;
          _gameLogic.speakWord(widget.question.word);
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _showDialog = true;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100.withOpacity(0.8),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 900),
              curve: Curves.easeInOut,
              top: _showCard ? 15 : -400,
              left: 20,
              right: 20,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 950),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: Card(
                  key: ValueKey<String>(widget.question.imagePath),
                  // elevation: 10,
                  margin: EdgeInsets.all(5),
                  color: _color ?? Colors.lightBlue,
                  child: Container(
                    height: 200,
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(widget.question.imagePath),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top: _hideDialog ? 600 : (_showDialog ? 250 : 600),
              left: 20,
              right: 20,
              child: _showDialog
                  ? _buildOptionsDialog(context, wordOptions)
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsDialog(BuildContext context, List<String> wordOptions) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade800,
            Colors.lightBlue.shade300,
            Colors.indigo.shade900
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.lightBlue, width: 2),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Select the correct word for the image',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: wordOptions.map((word) {
              return ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: selectedWord == word
                        ? _isLocked
                            ? (_color ?? Colors.lightBlue)
                            : Colors.orange
                        : Colors.white,
                  ),
                  onPressed: _canInteract
                      ? () {
                          _gameLogic.checkAnswer(
                              widget.question, word, context, widget.onAnswer,
                              (color, selected, isLocked, canInteract) {
                            setState(() {
                              _color = color;
                              selectedWord = selected;
                              _isLocked = isLocked;
                              _canInteract = canInteract;
                            });
                          });
                        }
                      : null,
                  child: Text(
                    word,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
