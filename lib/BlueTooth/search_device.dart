import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baguard_full/body/body.dart';
//import 'package:flutter_blue/gen/flutterblue.pb.dart' as protos;

//import 'package:flutter_blue/gen/flutterblue.pb.dart';
class BluethootDeviceLowPower extends StatefulWidget {
  //final Function connectStatus;

  const BluethootDeviceLowPower({
    Key? key,
    //required this.connectStatus,
  }) : super(key: key);
  _StateBluethootDeviceLowPower createState() =>
      _StateBluethootDeviceLowPower();
}

class _StateBluethootDeviceLowPower extends State<BluethootDeviceLowPower>
    with SingleTickerProviderStateMixin {
  List<BluetoothDevice> devices = [];
  late Stream<BluetoothDeviceState> state;
  late BluetoothDevice device;
  var scanSubscription;
  FlutterBlue bluetoothInstance = FlutterBlue.instance;
  bool endSearch = false;
  late SharedPreferences prefs;

  scanForDevice() async {
    bluetoothInstance
        .startScan(timeout: Duration(seconds: 5))
        .then((value) => endSearch = true);

    scanSubscription = bluetoothInstance.scanResults.listen((scanResult) {
      for (ScanResult r in scanResult) {
        endSearch = true;
        if (r.device.name == 'QPOWER' && !devices.contains(r.device)) {
          setState(() {
            devices.add(r.device);
            device = r.device;
          });
        }
      }
    });
  }

  void stopScanning() {
    bluetoothInstance.stopScan();
    scanSubscription.cancel();
  }

  connectToDevice(BluetoothDevice device) async {
    //flutter_blue makes our life easier
    await device.connect().onError((error, stackTrace) => 
    device.disconnect());
    
  }

  @override
  void initState() {
    super.initState();
    if (devices.isNotEmpty) {
      devices.clear();
    }
    FlutterBlue.instance.state.listen((state) {
      if (state == BluetoothState.off) {
      } else if (state == BluetoothState.on) {
        scanForDevice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: 300,
        child: Column(
          children: [
            Text(
              'Searching',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: !endSearch
                  ? LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: Colors.grey,
                      color: Colors.blue,
                    )
                  : Text(''),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            bluetoothInstance.stopScan();
                            connectToDevice(devices[index]);
                          },
                          child: Row(children: [
                            Icon(Icons.bluetooth_connected),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '${devices[index].name}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ]),
                        ),
                      ]),
                    ],
                  );
                },
              ),
            ),
            endSearch
                ? ElevatedButton(
                    onPressed: () {
                      scanForDevice();
                      setState(() {
                        endSearch = false;
                      });
                    },
                    child: Text('Try again'),
                  )
                : Text(''),
          ],
        ));
  }
}
