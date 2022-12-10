import 'dart:convert';

class WordsToDerive {
  final List<dynamic> listOfWordsCanBeDerived;

  const WordsToDerive({required this.listOfWordsCanBeDerived});

  factory WordsToDerive.fromJson(List<dynamic> json) {
    return WordsToDerive(
      listOfWordsCanBeDerived: json,
    );
  }
}
