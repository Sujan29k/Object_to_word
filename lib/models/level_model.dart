class Level {
  final int id;
  final List<String> objects;
  final String answer;
  final String hint;
  final List<String> letters;

  Level({
    required this.id,
    required this.objects,
    required this.answer,
    required this.hint,
    required this.letters,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'],
      objects: List<String>.from(json['objects']),
      answer: json['answer'],
      hint: json['hint'],
      letters: json['letters'] != null
          ? List<String>.from(json['letters'])
          : (json['answer'] as String).toUpperCase().split(''),
    );
  }
}
