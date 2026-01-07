import 'package:flutter/material.dart';
import '../models/level_model.dart';
import '../core/utils/level_loader.dart';

class GameProvider extends ChangeNotifier {
  // ---------------- STATE ----------------
  List<Level> _levels = [];
  int _currentIndex = 0;
  String _userAnswer = '';
  bool _isLoading = true;
  List<bool> _selectedLetters = []; // Track which letters are selected

  // ---------------- GETTERS ----------------
  bool get isLoading => _isLoading;

  Level? get currentLevel {
    if (_levels.isEmpty || _currentIndex >= _levels.length) {
      return null;
    }
    return _levels[_currentIndex];
  }

  String get userAnswer => _userAnswer;
  List<bool> get selectedLetters => _selectedLetters;

  // ---------------- INIT ----------------
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    _levels = await LevelLoader.loadLevels();
    _initializeSelectedLetters();

    _isLoading = false;
    notifyListeners();
  }

  void _initializeSelectedLetters() {
    final level = currentLevel;
    if (level != null) {
      _selectedLetters = List.filled(level.letters.length, false);
    }
  }

  // ---------------- GAME LOGIC ----------------
  void toggleLetter(int index) {
    final level = currentLevel;
    if (level == null) return;

    if (_selectedLetters[index]) {
      // Deselect: remove this letter from answer
      _selectedLetters[index] = false;
      _rebuildAnswerFromSelection();
    } else {
      // Select: add this letter to answer
      _selectedLetters[index] = true;
      _userAnswer += level.letters[index];
    }
    notifyListeners();
  }

  void _rebuildAnswerFromSelection() {
    final level = currentLevel;
    if (level == null) return;

    _userAnswer = '';
    for (int i = 0; i < _selectedLetters.length; i++) {
      if (_selectedLetters[i]) {
        _userAnswer += level.letters[i];
      }
    }
  }

  void clearAnswer() {
    _userAnswer = '';
    _selectedLetters = List.filled(_selectedLetters.length, false);
    notifyListeners();
  }

  bool checkAnswer() {
    final level = currentLevel;
    if (level == null) return false;

    return _userAnswer.toLowerCase() == level.answer.toLowerCase();
  }

  void nextLevel() {
    _userAnswer = '';
    _currentIndex++;
    _initializeSelectedLetters();
    notifyListeners();
  }
}
