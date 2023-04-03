import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
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
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'How fast can you type'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  String score = "";
  int _counter = 0;
  bool isStart = false;
  Color startcolor = Color.fromARGB(255, 152, 241, 195);
  List<String> names = [
    'Dan',
    'Sachibu',
    'Toufiq',
    'love',
    'Faith',
    'Destiny',
    'Dan',
    'Sachibu',
    'Toufiq',
    'love',
    'Faith',
    'Destiny'
  ];
  String currentword = "word";
  bool stattimer = false;
  int wordscont = 0;

  int scoreCalc = 0;
  // initState() {
  //   controller =
  //       AnimationController(vsync: this, duration: Duration(seconds: 10))
  //         ..addListener(() {
  //           setState(() {});
  //         });
  // }

  TextEditingController texts = TextEditingController();

  final int _duration = 20;
  final CountDownController _controller = CountDownController();

  bool readOnly = true;

  late FocusNode inputfocus;

  @override
  void initState() {
    inputfocus = FocusNode();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 20, 150, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 150,
                  width: 200,
                  color: Colors.green,
                  child: Center(
                    child: CircularCountDownTimer(
                      textFormat: "Timer",
                      controller: _controller,
                      autoStart: false,
                      ringColor: Colors.white,
                      fillColor: Colors.red,
                      backgroundColor: Colors.green,
                      initialDuration: 0,
                      duration: _duration,
                      width: 180,
                      height: 140,
                      onStart: (() {
                        print("counter started");
                      }),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      timeFormatterFunction:
                          ((defaultFormatterFunction, duration) {
                        if (duration.inSeconds == 0) {
                          return "Timer";
                        } else {
                          return Function.apply(
                              defaultFormatterFunction, [duration]);
                        }
                      }),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  width: 200,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      "Score:" + score,
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 20, 150, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _controller.start();
                          isStart = true;
                          setState(() {
                            inputfocus.requestFocus();
                            readOnly = false;
                          });
                          Timer(Duration(seconds: _duration), () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => endDialog());
                            setState(() {
                              score = scoreCalc.toString();
                              _controller.pause();
                            });
                            readOnly = true;
                            isStart = false;
                          });
                        },
                        child: Text("start"))
                  ],
                ),
                Text(
                  currentword,
                  style: TextStyle(fontSize: 100),
                ),
                Container(
                  color: Color.fromARGB(255, 0, 0, 0),
                  height: 2,
                  width: MediaQuery.of(context).size.width / 0.4,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: isStart ? startcolor : Colors.white,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: input(),
                ),
                // SizedBox(
                //   height: 60,
                // ),
                // LinearProgressIndicator(
                //   value: controller.value,
                //   semanticsLabel: "progress",
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget endDialog() {
    return AlertDialog(
      title: Text(
        "Time up!!!",
      ),
      titleTextStyle: TextStyle(color: Colors.red, fontSize: 40),
      content: Text(
          "Your typing speed is " + scoreCalc.toString() + "words" + "/minute"),
    );
    _counter = 0;
  }

  Widget input() {
    return TextFormField(
      focusNode: inputfocus,
      readOnly: readOnly,
      controller: texts,
      onChanged: (value) {
        String typed = value.trim();

        if (typed == currentword) {
          setState(() {
            currentword = names[_counter];
            texts.clear();
          });

          scoreCalc++;
          _counter++;
        }
      },
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: isStart ? "Type the word above" : "Click on start to begin",
          hintStyle: TextStyle(fontFamily: 'OpenSans'),
          border: InputBorder.none),
    );
  }
}
