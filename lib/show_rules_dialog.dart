import 'package:flutter/material.dart';

const String wordRandom = "random";
final List<String> rulesOfRandom = [
  "THE WORD YOU ENTERED SHOULD CONTAIN AT LEAST 4 LETTER",
  "YOU CAN ONLY USE LETTERS IN THE BOXES",
  "for example: if there are two of M in the boxes, you cant use more than 2 M in a word",
  "IF YOU ENTER A WORD THAT YOU ALREADY ENTERED, ERROR WILL OCCUR",
  "YOU NEED TO ENTER MEANINGFUL WORDS"
];

Future<void> showRulesDialogBuilder(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Rules of:'),
        content: SizedBox(
          width: 300,
          height: 400,
          child: Column(
            children: [
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                  ),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          border: index < 5
                              ? const Border(
                                  top:
                                      BorderSide(color: Colors.black, width: 2),
                                  left:
                                      BorderSide(color: Colors.black, width: 2),
                                  bottom:
                                      BorderSide(color: Colors.black, width: 2))
                              : Border.all(color: Colors.black, width: 2),
                        ),

                        // Border.all(color: Colors.black, width: 5)),
                        child: Center(
                          child: Text(
                            wordRandom[index].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )),
              for (var x = 0; x < rulesOfRandom.length; x++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${x + 1}: ${rulesOfRandom[x]}"),
                ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
