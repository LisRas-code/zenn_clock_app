import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'リアルタイム取得'),
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
  String now_time = DateFormat('HH:mm:ss').format(DateTime.now()).toString();
  int index = 0;
  List<int> math_array = [1, 120, 360, 180];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("ja");
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  void _onTimer(Timer timer) {
    var new_time = DateFormat('HH:mm:ss').format(DateTime.now());
    setState(() => {
          now_time = new_time,
        });
  }

  int dispNowTime() {
    int now = int.parse(now_time.substring(7)) == 0
        ? 10
        : int.parse(now_time.substring(7));
    return now;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.yMMMMEEEEd('ja').format(DateTime.now()).toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.yellow[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("ただいまの時刻"),
                  Text(
                    '${now_time}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (index = 0; index < dispNowTime(); index++)
                          Text(" ■"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Transform.rotate(
                    angle:
                        (dispNowTime() * 36) * (pi / 360), //90度を「(π) ÷ 180」にかける
                    child: Container(
                      width: 60,
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
