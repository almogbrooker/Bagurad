import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_foreground_task/ui/with_foreground_task.dart';
import 'Appbar/appbar.dart';
import 'BlueTooth/search_device.dart';
import 'body/body.dart';
import 'package:baguard_full/body/back_ground_image.dart';
import 'splash.dart';
import 'dart:async';
Future main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baguard',
      home: WithForegroundTask(
        child: Splase(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
        image: AssetImage('assets/bag.jpg'),
        child: Scaffold(
          appBar: AppBarQ(
            context: context,
          ),
          backgroundColor: Colors.transparent,
          body: bodyList(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => BluethootDeviceLowPower());
            },
          ),
        ));
  }
}
