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

  Map<String, dynamic> test() {
    Map<String, int> obj = {};
    int numOfChar = 0;
    String origin = "abcdaabff";
    List<String> listOfOrigin = origin.split("");
    List<String> setOfOrigin = listOfOrigin.toSet().toList();
    print(setOfOrigin);
    for (var n = 0; n < setOfOrigin.length; n++) {
      obj[setOfOrigin[n]] = 0;
    }
    for (var n = 0; n < listOfOrigin.length; n++) {
      for (var x = 0; x < setOfOrigin.length; x++) {
        if (setOfOrigin[x] == listOfOrigin[n]) {
          obj[setOfOrigin[x]] = obj[setOfOrigin[x]]! + 1;
        }
      }
    }

    // print(obj);
    return obj;
  }

  Map<String, dynamic> obje = test();
  print("obje:: ${obje["a"]}");
}
 // if (listOfOrigin[n] == listOfOrigin[0]) {
      //   obj[listOfOrigin[n]] = obj[listOfOrigin[n]]! + 1;
      // }