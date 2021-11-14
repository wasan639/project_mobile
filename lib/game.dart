import 'dart:math';

class Game {
  final int _answer;
  int _totalGGuesses = 0;

  Game() : _answer = Random().nextInt(100) + 1 {
    print('The anser is: $_answer');
  }

  int get totalGuesses {
    return _totalGGuesses;
  }

  int doGuess(int num) {
    if (num > _answer) {
      return 1;
    } else if (num < _answer) {
      return -1;
    } else {
      return 0;
    }
  }
}
