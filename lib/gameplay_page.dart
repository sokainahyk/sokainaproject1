import 'dart:math';
import 'package:flutter/material.dart';
import 'result_page.dart';
import 'difficulty_level.dart';

class GameplayPage extends StatefulWidget {
  final DifficultyLevel difficultyLevel;

  const GameplayPage({super.key, required this.difficultyLevel});

  @override
  GameplayPageState createState() => GameplayPageState();
}



class GameplayPageState extends State<GameplayPage> {
  late int _targetNumber;
  int? _userGuess;
  int _attempts = 0;
  bool _isGameOver = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    // Adjust the range based on difficulty level
    switch (widget.difficultyLevel) {
      case DifficultyLevel.easy:
        _targetNumber = _generateRandomNumber(1, 10);
        break;
      case DifficultyLevel.medium:
        _targetNumber = _generateRandomNumber(1, 50);
        break;
      case DifficultyLevel.hard:
        _targetNumber = _generateRandomNumber(1, 100);
        break;
    }
  }

  int _generateRandomNumber(int min, int max) {
    return min + Random().nextInt(max - min + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the Number'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Guess a number between 1 and ${_getMaxNumber()}',
              style: const TextStyle(fontSize: 20,color: Colors.teal),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _userGuess = int.tryParse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Enter your guess',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isGameOver ? null : () => _checkGuess(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              child: const Text(
                'Submit Guess',
                style: TextStyle(fontSize: 16,color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _isGameOver ? 'Game Over!' : 'Attempts: $_attempts',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.teal),
            ),
            const SizedBox(height: 20),
            Text(
              _isGameOver ? '' : _getFeedback(),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  int _getMaxNumber() {
    switch (widget.difficultyLevel) {
      case DifficultyLevel.easy:
        return 10;
      case DifficultyLevel.medium:
        return 50;
      case DifficultyLevel.hard:
        return 100;
    }
  }

  void _checkGuess(BuildContext context) {
    setState(() {
      _attempts++;

      if (_userGuess == _targetNumber) {
        _showResult(context, true);
      } else {
        String feedback = _provideFeedback();
        _showFeedbackDialog(context, feedback);
      }
    });
  }

  String _provideFeedback() {
    if (_userGuess == null) {
      return ' enter a valid number';
    } else if (_userGuess! < _targetNumber) {
      return ' Try a higher number!';
    } else {
      return ' Try a lower number!';
    }
  }

  void _showFeedbackDialog(BuildContext context, String feedback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Feedback'),
          content: Text(feedback),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  void _showResult(BuildContext context, bool isWinner) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(attempts: _attempts, isWinner: isWinner),
      ),
    );
    setState(() {
      _isGameOver = true;
    });
  }
  String _getFeedback() {
    if (_userGuess == null) {
      return 'Please enter a valid number';
    } else if (_userGuess! < _targetNumber) {
      return 'Too low! Try a higher number.';
    } else if (_userGuess! > _targetNumber) {
      return 'Too high! Try a lower number.';
    } else {
      return 'Congratulations! You guessed it!';
    }
  }


}

