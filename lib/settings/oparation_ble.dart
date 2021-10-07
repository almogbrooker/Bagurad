import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:baguard_full/body/ble_body.dart';
class BuildOperation extends StatefulWidget {
  final BluetoothDevice device;
  const BuildOperation(
    this.device, {
    Key? key,
  }) : super(key: key);

  @override
  _StateBuildOperation createState() => _StateBuildOperation();
}

class _StateBuildOperation extends State<BuildOperation> {
  bool valNotify = true;
  double slidevalue1 = 4;
  double slidevalue2 = 4;
  String status1 = 'Medium';
  String status2 = 'Medium';
  bool changeConnection = true;

  onChangeFunction(bool newValue) {
    setState(() {
      valNotify = newValue;
    });
  }

  onChangeFunctionSlide1(double newValue) {
    setState(() {
      if (newValue < 3.4) {
        status1 = 'High ';
      } else if (newValue < 4.7) {
        status1 = 'Medium ';
      } else {
        status1 = 'Low ';
      }
      slidevalue1 = getNumber(newValue, precision: 1);
    });
  }

  onChangeFunctionSlide2(double newValue) {
    setState(() {
      if (newValue < 3.4) {
        status2 = 'High ';
      } else if (newValue < 4.7) {
        status2 = 'Medium ';
      } else {
        status2 = 'Low ';
      }
      slidevalue2 = getNumber(newValue, precision: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        buildNotifyOptionSw(
          Icons.notification_important, // Icon you want
          'Alert', // title for the row
          'Enable theft alert', // subtitle
          valNotify, // switch or slide animation
          onChangeFunction, // function setState
        ),
        buildNotifyOptionSl(
          Icons.radar, // Icon you want
          'Movment Sensitivity', // title for the row
          "$status2($slidevalue2\m)", // subtitle
          slidevalue2, // switch or slide animation
          onChangeFunctionSlide2,
        ),
        AnimatedButtonBar(
          radius: 20.0,
          padding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.white,
          foregroundColor: changeConnection ? Colors.green : Colors.red,
          elevation: 20,
          borderColor: Colors.white24,
          borderWidth: 2,
          innerVerticalPadding: 10,
          children: [
            ButtonBarEntry(
                onTap: () async {
                  setState(() {
                    changeConnection = true;
                  });
                  widget.device.connect();
                  CreatBoxForDevice(widget.device);
                },
                child: Text('Connect')),
            ButtonBarEntry(
                onTap: () {
                  widget.device.disconnect();
                  setState(() {
                    changeConnection = false;
                  });
                },
                child: Text('Disconnect')),
          ],
        ),
      ]),
    );
  }
}

Padding buildNotifyOptionSw(IconData icon, String title, String subtitle,
    var value, Function boolState) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              Icon(
                icon,
                color: value != true ? Colors.grey : Colors.green,
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ),
        Transform.scale(
          scale: 0.7,
          child: Switch.adaptive(
              activeColor: Colors.blue,
              value: value,
              onChanged: (bool newValue) {
                boolState(newValue);
              }),
        ),
      ],
    ),
  );
}

Padding buildNotifyOptionSl(IconData icon, String title, String subtitle,
    var value, Function boolState) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    child: Column(
      children: [
        Container(
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
                size: 20,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ),
        Transform.scale(
            scale: 1,
            child: Slider.adaptive(
                value: value,
                min: 2,
                max: 6,
                onChanged: (double newValue) {
                  boolState(newValue);
                })),
      ],
    ),
  );
}

double getNumber(double input, {int precision = 2}) =>
    double.parse('$input'.substring(0, '$input'.indexOf('.') + precision + 1));
