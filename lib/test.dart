import 'package:game/dnm.dart';

Map<String, dynamic> test(String origin) {
  Map<String, int> obj = {};
  // int numOfChar = 0;
  //  String origin = "müstehcen";
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

  print("OBJ TEST: $obj");
  return obj;
}

Map<String, dynamic> guess(String guessWord) {
  final Map<String, int> obj = {};
//final int numOfChar = 0;
  // final String origin = "tümcem";
  final List<String> listOfOrigin = guessWord.split("");
  print("listOfOrigin $listOfOrigin");
  final List<String> setOfOrigin = listOfOrigin.toSet().toList();
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

  print("THIS IS GUESS OBK $obj");
  return obj;
}

// final Map<String, dynamic> origin = test("kuluçka");

bool check(
    List<String> argList, Map<String, dynamic> origin, String guessWord) {
  print("origin from test $origin");
  final Map<String, dynamic> guessUser = guess(guessWord);
  print("guessUser TEST.DART: $guessUser");
  final List guessList = guessUser.keys.toList();
  print("guessList TEST.DART $guessList");
  final isTrue = isContain(argList, guessWord);
  for (var n in guessList) {
    if (!isTrue || guessUser[n] > origin[n]) {
      print("sth else gone wrong");
      return false;
    }
  }
  return true;
}

bool checkContains(List<String> arg1, String arg2) => arg1.contains(arg2);

void main() {
  final x = checkContains(["arg1", "arg2"], "arg3");
  print(x);
}

// bool isContain(List<String> argList, String arg) {
//   final charSetOfArg = arg.split("").toSet().toList();
//   for (var n = 0; n < charSetOfArg.length; n++) {
//     if (argList.contains(charSetOfArg[n])) {
//       return true;
//     }
//   }
//   return false;
// }
  // Map<String, dynamic> obje = test();
  // print("obje:: $obje");
  // Map<String, dynamic> objec = guess("asdfg");
  // print(objec);
 // check("kulaçç");

