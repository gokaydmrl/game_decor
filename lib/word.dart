import 'dart:convert';

class Word {
  final String theWord;
  final String randomVerOfWord;
  final List<dynamic> wordsCanBeDerived;

  const Word(
      {required this.theWord,
      required this.randomVerOfWord,
      required this.wordsCanBeDerived});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      theWord: json["theWord"] as String,
      randomVerOfWord: json["randomVerOfWord"] as String,
      wordsCanBeDerived: json["wordsCanBeDerived"] as List<dynamic>,
    );
  }
}