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
