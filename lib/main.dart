import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:game/word.dart';
import 'package:game/words_derived.dart';
import 'package:http/http.dart';

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
  final String word = "MÜNFERİT";
  final String randomOrder = "FMETÜNRİ";
  late final TextEditingController guessController;

  Future<List<WordsToDerive>> getWordsDerived() async {
    try {
      final response = await Dio(BaseOptions(
        responseType: ResponseType.plain,
        contentType: 'application/json',
      )).get('http://localhost:3001/');
      final res = jsonDecode(response.toString());
      final aListOfWords = (res as List)
          .map((e) => WordsToDerive.fromJson(e.wordsCanBeDerived))
          .toList();
      print("aListOfWords:: $aListOfWords");
      return aListOfWords;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Word>> getHttp() async {
    try {
      final response = await Dio(BaseOptions(
        responseType: ResponseType.plain,
        contentType: 'application/json',
      )).get('http://localhost:3001/');
      final res = json.decode(response.toString());
      final List<Word> aList = (res as List)
          .map(
            (e) => Word.fromJson(e),
          )
          .toList();
      print(" khara ${aList[0].wordsCanBeDerived}");
      //  print(aList[0].thWordsToDeriveeWord);

      return aList;
      //  print("res: $res");
      //  print("this is res $response");
      // print("response:: ${jsonDecode(response.toString())}");
    } catch (e) {
      print("e:: $e");
      return Future.error(e);
    }
  }

//  late final TextEditingController textController;
//  late final TextEditingController textController2;
  @override
  void initState() {
    super.initState();
    guessController = TextEditingController();
    getWordsDerived();
    // textController = TextEditingController();
    // textController2 = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    // textController.dispose();
    // textController2.dispose()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  itemCount: 7,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),

                  // Shrink the size, otherwise it uses unlimited height and enables scroll
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          border: index < 6
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
                            child: FutureBuilder<List<Word>>(
                          future: getHttp(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data![0].randomVerOfWord[index]
                                    .toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return const CircularProgressIndicator();
                          },
                        )),
                      )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: guessController,
              decoration: const InputDecoration(
                  label: Text("your guess"),
                  icon: Icon(Icons.abc),
                  enabledBorder: OutlineInputBorder()),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (guessController.text.toLowerCase() == word.toLowerCase())
            print("true");
          else
            print("no");
        },
        child: const Icon(Icons.key_rounded),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
