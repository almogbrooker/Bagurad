import 'package:flutter/material.dart';
import 'package:baguard_full/settings/settings_page.dart';

class AppBarQ extends AppBar {
  final BuildContext context;
  AppBarQ({required this.context})
      : super(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Colors.black,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/icon/AppBarLogo.png',
                  fit: BoxFit.cover,
                  width: 60,
                ),
                Text(
                  'Baguard',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
                icon: Icon(
                  Icons.settings,
                ),
              ),
            ]);
}
