import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fbroadcast/fbroadcast.dart';

import 'broadcast_keys.dart';
import 'location_server.dart';

void main() {
  LocationServer();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var text = "Run Count And Goto Next";

  @override
  void initState() {
    FBroadcast.instance().register(Key_StopCount, (_, __) {
      runAddCount?.cancel();
      setState(() {
        text = "STOP!";
      });
    }, context: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'FBroadcast',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
          ],
        ),
      ),
    );
  }

  int msgCount = 0;
  Timer? runAddCount;

  addCount(BuildContext context) {
    runAddCount = Timer(Duration(milliseconds: 1000), () {
      FBroadcast.instance().broadcast(Key_MsgCount, value: ++msgCount);
      addCount(context);
    });
  }

  @override
  void dispose() {
    FBroadcast.instance().unregister(this);
    super.dispose();
  }
}
