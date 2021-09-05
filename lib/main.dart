import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'Appbar/appbar.dart';
import 'BlueTooth/search_device.dart';
import 'body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLutter aPP',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BluetoothDevice> devices = [];
  bool connect = false;
  late ScanResult rssi;

  bool _addListDevices(BluetoothDevice device, bool add) {
    if (!devices.contains(device)) {
      setState(() {
        if (add) {
          devices.add(device);
        }
      });
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarQ(
        context: context,
      ),
      backgroundColor: Colors.white,
      body: bodyList(devices),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => BluethootDeviceLowPower(
                    _addListDevices,
                  ));
        },
      ),
    );
  }
}
