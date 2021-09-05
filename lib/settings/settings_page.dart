import 'package:flutter/material.dart';

import './operation_mode.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          actions: <Widget>[
            Icon(Icons.access_alarm),
          ],
          title: Text(
            'Settings',
            style: TextStyle(fontSize: 22),
          ),
          backgroundColor: Colors.black,
        ),
        body: BuildOperation(),
        extendBody: true,
      );
}
