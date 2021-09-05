import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:baguard_full/ble_body.dart';

class bodyList extends StatefulWidget {
  List<BluetoothDevice> devices;
  //ScanResult rssiPhone;
  bodyList(this.devices, {Key? key}) : super(key: key);
  @override
  _bodyListState createState() => _bodyListState();
}

class _bodyListState extends State<bodyList> {
  FlutterBlue bluetoothInstance = FlutterBlue.instance;

  void addConnectedDevice() async {
    await bluetoothInstance.connectedDevices.then((value) {
      for (BluetoothDevice d in value) {
        setState(() {
          widget.devices.add(d);
        });
      }
    });
    bluetoothInstance.connectedDevices.then((value) {
      value.remove(0);
    });
  }

  @override
  void initState() {
    addConnectedDevice();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      alignment: Alignment.center,
      child: ListView.builder(
          itemCount: widget.devices.length,
          itemBuilder: (context, index) {
            return CreatBoxForDevice(widget.devices[index]);
          }),
    );
  }
}
