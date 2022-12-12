import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:game/word.dart';
import 'package:game/words_derived.dart';
import 'package:http/http.dart';
import 'package:game/test.dart';
import 'package:game/dnm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String word = "KULUÇKA";
  final String randomOrder = "LÇUKAUK";
  final List<String> wordsCanBeDerived = [
    "kuluçka",
    "uçak",
    "kul",
    "kauçuk",
    "kulaç",
    "çak",
    "kaç",
    "kulak",
    "çal",
    "ulak",
    "kukla",
    "kulak",
    "kuluç",
  ];
  final List<String> listOfGuesses = [];
  late final TextEditingController guessController;
  late Map<String, dynamic> origin = {};
  late List<String> setOfOrigin = [];
  bool isError = false;
  String errorMessage =
      "the word you entered is either meaningless or contains a character used more than allowed";
  String emptyListMessage = "waith";
  // Future<List<WordsToDerive>> getWordsDerived() async {
  //   try {
  //     final response = await Dio(BaseOptions(
  //       responseType: ResponseType.plain,
  //       contentType: 'application/json',
  //     )).get('http://localhost:3001/');
  //     final res = jsonDecode(response.toString());
  //     final aListOfWords = (res as List)
  //         .map((e) => WordsToDerive.fromJson(e.wordsCanBeDerived))
  //         .toList();
  //     print("aListOfWords:: $aListOfWords");
  //     return aListOfWords;
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // Future<List<Word>> getHttp() async {
  //   try {
  //     final response = await Dio(BaseOptions(
  //       responseType: ResponseType.plain,
  //       contentType: 'application/json',
  //     )).get('http://localhost:3001/');
  //     final res = json.decode(response.toString());
  //     final List<Word> aList = (res as List)
  //         .map(
  //           (e) => Word.fromJson(e),
  //         )
  //         .toList();
  //     print(" khara ${aList[0].wordsCanBeDerived}");
  //     //  print(aList[0].thWordsToDeriveeWord);

  //     return aList;
  //     //  print("res: $res");
  //     //  print("this is res $response");
  //     // print("response:: ${jsonDecode(response.toString())}");
  //   } catch (e) {
  //     print("e:: $e");
  //     return Future.error(e);
  //   }
  // }

//  late final TextEditingController textController;
//  late final TextEditingController textController2;
  @override
  void initState() {
    super.initState();
    guessController = TextEditingController();
    origin = test(word);
    setOfOrigin = word.split("").toSet().toList();
  }

  @override
  void dispose() {
    super.dispose();
    guessController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("this is origin from build $origin");
    print("this is setOfOrigin from build $setOfOrigin");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "words remaining ${listOfGuesses.length}/${wordsCanBeDerived.length}")
              ],
            ),
          ),
          Center(
            child: Padding(
              // Move it to the top a little bit
              padding: const EdgeInsets.only(
                bottom: 125,
                left: 25,
                right: 25,
              ),

              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  // Statically give the count, so that MAXIMUM PERFORMANCEEE
                  itemCount: word.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: word.length,
                  ),

                  // Shrink the size, otherwise it uses unlimited height and enables scroll
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          border: index < word.length - 1
                              ? const Border(
                                  top:
                                      BorderSide(color: Colors.black, width: 3),
                                  left:
                                      BorderSide(color: Colors.black, width: 3),
                                  bottom:
                                      BorderSide(color: Colors.black, width: 3))
                              : Border.all(color: Colors.black, width: 3),
                        ),

                        // Border.all(color: Colors.black, width: 5)),
                        child: Center(
                          child: Text(
                            randomOrder[index].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: guessController,
              decoration: InputDecoration(
                label: const Text("your guess"),
                icon: const Icon(Icons.abc),
                enabledBorder: const OutlineInputBorder(),
                errorText: isError ? errorMessage : null,
                errorMaxLines: 2,
              ),
            ),
          ),
          for (var aGuess in listOfGuesses)
            Flexible(
                child: Text(listOfGuesses.isEmpty ? emptyListMessage : aGuess))
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("origin $origin");
          bool isContainsWord = checkContains(
              wordsCanBeDerived, guessController.text.toLowerCase());
          bool isTrue = check(setOfOrigin, origin, guessController.text);
          bool isContainsChar = isContain(setOfOrigin, guessController.text);
          if (isTrue && isContainsChar && isContainsWord) {
            setState(() {
              listOfGuesses.add(guessController.text);
              isError = false;
            });
          } else {
            setState(() {
              isError = true;
            });

            print(
                "the word you entered is either meaningless or contains a character used more than allowed");
          }
          guessController.text = "";
        },
        child: const Icon(Icons.key_rounded),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
