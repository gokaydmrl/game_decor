import 'package:flutter/material.dart';

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
  final String word = "kulaç";
//  late final TextEditingController textController;
//  late final TextEditingController textController2;
  @override
  void initState() {
    super.initState();
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
      body: Center(
        child: Padding(
          // Move it to the top a little bit
          padding: const EdgeInsets.only(
            bottom: 125,
            left: 25,
            right: 25,
          ),

          child: GridView.builder(
              // Statically give the count, so that MAXIMUM PERFORMANCEEE
              itemCount: 5,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),

              // Shrink the size, otherwise it uses unlimited height and enables scroll
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: index < 4
                          ? const Border(
                              top: BorderSide(color: Colors.black, width: 3),
                              left: BorderSide(color: Colors.black, width: 3),
                              bottom: BorderSide(color: Colors.black, width: 3))
                          : Border.all(color: Colors.black, width: 3),
                    ),

                    // Border.all(color: Colors.black, width: 5)),
                    child: Center(child: Text("$index")),
                  )),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => print("")),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
