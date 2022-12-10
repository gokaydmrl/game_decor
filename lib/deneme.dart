import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:game/words_derived.dart';

class RandomWord {
  final String randomVerOfWord;

  const RandomWord({required this.randomVerOfWord});

  factory RandomWord.fromJson(String json) {
    return RandomWord(
      randomVerOfWord: json,
    );
  }
}

void main() async {
  late RandomWord kelime;
  Future<RandomWord> rndm() async {
    try {
      final response = await Dio(BaseOptions(
        responseType: ResponseType.plain,
        contentType: 'application/json',
      )).get('http://localhost:3001/');
      final res = jsonDecode(response.toString());
      final randomWord = (res as List)
          .map((e) => RandomWord.fromJson(e["randomVerOfWord"]))
          .toList()[0];
      kelime = randomWord;
      return randomWord;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<WordsToDerive>> getWordsDerived() async {
    try {
      final response = await Dio(BaseOptions(
        responseType: ResponseType.plain,
        contentType: 'application/json',
      )).get('http://localhost:3001/');
      final res = jsonDecode(response.toString());
      final aListOfWords = (res as List)
          .map((e) => WordsToDerive.fromJson(e["wordsCanBeDerived"]))
          .toList();

      print("aListOfWords:: ${aListOfWords[0].listOfWordsCanBeDerived}");
      return aListOfWords;
    } catch (e) {
      return Future.error(e);
    }
  }

  String listA = '["one", "two", "three", "four"]';
  var a = jsonDecode(listA);

  String x = "asd fed, asdasd";
  List y = x.split(" ");
  print(y[0]);
  print("a::  $a");
  getWordsDerived().then((value) => print("list ${value[0]}"));
  final RandomWord zz = await rndm();
  print("zz: ${zz.randomVerOfWord}");

  print("kelime ${kelime.randomVerOfWord}");
  // final z = getWordsDerived();
  // print(z);
}
