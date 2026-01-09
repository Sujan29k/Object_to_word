class Level {
  final int id;
  final List<String> objects;
  final String answer;
  final String hint;
  final List<String> letters;
  late List<String> shuffledLetters;

  Level({
    required this.id,
    required this.objects,
    required this.answer,
    required this.hint,
    required this.letters,
    List<String>? shuffledLetters,
  }) {
    this.shuffledLetters = shuffledLetters ?? List<String>.from(letters);
  }

  factory Level.fromJson(Map<String, dynamic> json) {
    final letters = json['letters'] != null
        ? List<String>.from(json['letters'])
        : (json['answer'] as String).toUpperCase().split('');

    return Level(
      id: json['id'],
      objects: List<String>.from(json['objects']),
      answer: json['answer'],
      hint: json['hint'],
      letters: letters,
    );
  }

  void shuffleLetters() {
    shuffledLetters = List.from(letters)..shuffle();
  }
}
