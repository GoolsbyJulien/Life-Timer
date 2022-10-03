import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Life Time',
        theme: ThemeData(
        
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        home: new Scaffold(
        
          backgroundColor: Colors.black,
          body: Center(child: SizedBox(child: Clock())),
        ));
  }
}

class Clock extends StatefulWidget {
  const Clock({
    Key key,
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {

    var f = new NumberFormat("###,###,###", "en_US");
  Duration time() {
    DateTime now = DateTime.now();

    DateTime then = DateTime(1920, 4, 16, 2, 0);

    return now.difference(then);
  }

  Future<AudioPlayer> playLocalAsset(int i) async {
    AudioCache cache = new AudioCache();
    if(i ==0)
    return await cache.play("audio/tick.wav");
    else{
    return await cache.play("audio/tock.wav");

    }
  }

  Timer timer;
  DateTime lastTime = DateTime.now();
  void startTimer() {
    Timer.periodic(new Duration(milliseconds: 1000), (timer) {
      setState(() {
        lastTime = DateTime.now();

         playLocalAsset(time().inSeconds % 10 == 0 ? 1:0);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      f.format( time().inSeconds),
      style: TextStyle(color: Colors.white, fontSize: 40),
    );
  }
}

class Date {}
