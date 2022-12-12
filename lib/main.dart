import 'dart:async';
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
  void addToList(String guessWord) {
    listOfGuesses.add(guessWord.toUpperCase());
  }

  ///
  Future<void> showRulesDialogBuilder(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text('A dialog is a type of modal window that\n'
              'appears in front of app content to\n'
              'provide critical information, or prompt\n'
              'for a decision to be made.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool dnm = false;
  bool deneme() {
    setState(() {
      dnm = !dnm;
    });
    return dnm;
  }

  ///

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

    // scheduleMicrotask(() => showRulesDialogBuilder(context));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showRulesDialogBuilder(context);
    });
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
    print("dnm $dnm");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 20, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  onEnd: () {
                    setState(() {
                      dnm = false;
                    });
                  },
                  width: 200,
                  height: 30,
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.fastOutSlowIn,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: dnm
                        ? Color.fromARGB(239, 41, 199, 9)
                        : Color.fromARGB(255, 255, 255, 255),
                    border: Border(
                      top: BorderSide(color: Color.fromARGB(255, 19, 0, 0)),
                      left: BorderSide(color: Color.fromARGB(255, 19, 0, 0)),
                      right: BorderSide(color: Color.fromARGB(255, 19, 0, 0)),
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 19, 0, 0), width: 4),
                    ),
                  ),
                  child: Text(
                      "WORDS REMAINING ${listOfGuesses.length}/${wordsCanBeDerived.length}"),
                )
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
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) {
                guessController.value = TextEditingValue(
                    text: value.toUpperCase(),
                    selection: guessController.selection);
              },
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
            Text(listOfGuesses.isEmpty ? emptyListMessage : aGuess)
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("origin $origin");
          bool checkIfListContainsWord = checkIfContainsWord(
              listOfGuesses, guessController.text.toUpperCase());
          bool isContainsWord = checkContains(
              wordsCanBeDerived, guessController.text.toLowerCase());
          bool isTrue =
              check(setOfOrigin, origin, guessController.text.toUpperCase());
          bool isContainsChar =
              isContain(setOfOrigin, guessController.text.toUpperCase());
          if (!checkIfListContainsWord &&
              isTrue &&
              isContainsChar &&
              isContainsWord) {
            deneme();
            setState(() {
              addToList(guessController.text);
              isError = false;

              print("setStaetednm $dnm");
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
