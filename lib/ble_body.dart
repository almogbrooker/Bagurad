import 'dart:math';

import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:baguard_full/BlueTooth/model/notifiction_value.dart';
import 'dart:async';

class CreatBoxForDevice extends StatefulWidget {
  final BluetoothDevice device;
  const CreatBoxForDevice(this.device, {Key? key}) : super(key: key);

  @override
  _CreatBoxForDeviceState createState() => _CreatBoxForDeviceState();
}

class _CreatBoxForDeviceState extends State<CreatBoxForDevice> {
  int _battrey = 0;
  int _rssi = 1;
  var _movementX;
  var _movementY;
  var _movementZ;
  var rssiPone;
  int _avgRssi = 0;
  bool _status = false;
  var dis;
  late Timer _clockTimer;
  _notificationBattery(List<int> uuidBattery) {
    uuidBattery.forEach((value) {
      setState(() {
        _battrey = value;
      });
    });
  }

  _notificationRssi(List<int> uuidRssi) {
    uuidRssi.forEach((value) {
      setState(() {
        _rssi = value;
      });
    });
  }

  _notificationMovmentX(List<int> uuidX) {
    uuidX.forEach((value) {
      setState(() {
        _movementX = value;
      });
    });
  }

  _notificationMovmentY(List<int> uuidY) {
    uuidY.forEach((value) {
      setState(() {
        _movementY = value;
      });
    });
  }

  _notificationMovmentZ(List<int> uuidZ) {
    uuidZ.forEach((value) {
      setState(() {
        _movementZ = value;
      });
    });
  }

  _checkState() async {
    await widget.device.state.listen((event) {
      setState(() {
        if (event.index == 2) {
          _status = true;
        } else {
          _status = false;
        }
      });
    });
  }

  @override
  void initState() {
    _checkState();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      //widget.device.readRssi().then((value) {
        //_avgRssi = ((-_rssi + value) / 2).round();
        _avgRssi = _rssi;
        dis = double.parse(
            (pow(10, ((-61 - (_avgRssi)) / 20)).toStringAsFixed(1)));
     // });
    });

    // TODO: implement initState
    super.initState();
    createNotifiction(widget.device, _notificationRssi, _notificationBattery,
        _notificationMovmentX, _notificationMovmentY, _notificationMovmentZ);
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.device.name}',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('${widget.device.id.id}'),
            Container(
              child: WidgetCircularAnimator(
                innerAnimation: Curves.easeInOutBack,
                innerColor: _status ? Colors.blueAccent : Colors.grey,
                outerColor: Colors.green,
                singleRing: !_status,
                innerAnimationSeconds: 3,
                size: 150,
                child: Container(
                  child: Icon(Icons.bluetooth_audio),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _status ? Colors.green[300] : Colors.grey,
                  ),
                ),
              ),
            ),
            Text(
              (_status) ? 'Connecting' : 'Searcing..,',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Battery',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Level',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        (_status) ? '$_battrey%' : '-',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Signal',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Stength',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        (_status) ? '${_avgRssi}db' : '-',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Estimated',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Distance',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text((_status) ? '$dis' : '-',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ],
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
