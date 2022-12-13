void main() {
  // isContain(["a", "b", "c"], "bar");
  // print(contains(["a", "b", "c"], "abc"));
}

bool contains(List<String> argList, String arg) {
  final charSetOfArg = arg.split("").toSet().toList();

  return charSetOfArg.every((element) => element == arg);
}

bool isContain(List<String> argList, String arg) {
  final charSetOfArg = arg.split("").toSet().toList();
  for (var n = 0; n < charSetOfArg.length; n++) {
    if (!argList.contains(charSetOfArg[n])) {
      print("false");
      return false;
    }
  }
  print("true");
  return true;
}

bool checkIfContainsWord(List<String> arg1, String arg2) => arg1.contains(arg2);


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