import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

const String battery = '180f';
const String batteryvalue = '2a19';
const String rssi = '181c';

const String moveX = '1820';
const String moveY = '1821';
const String moveZ = '1822';

  createNotifiction(BluetoothDevice device, Function rssiF, Function batteryF,
    Function movementXF, Function movementYF, Function movementZF) async {
  List<BluetoothService> services = await device.discoverServices();
  List<BluetoothCharacteristic> c;
  List<String> uuidList = [battery, rssi,moveX,moveY,moveZ,batteryvalue];
 

  services.forEach((service) {
    var chars = service.uuid.toString().substring(4, 8);
    if (uuidList.contains(chars)) {
      c = service.characteristics;
      c.forEach((characters) async {
        if (characters.properties.notify) {
          var dchars = characters.uuid.toString().substring(4,8);
          characters.value.listen(
            (value) {
              switch (dchars) {
                case rssi:
                  {
                    rssiF(value);
                  }
                  break;
                case batteryvalue:
                  {
                    
                    batteryF(value);
                  }
                  break;
                case moveX:
                  {
                    movementXF(value);
                  }
                  break;
                case moveY:
                  {
                    movementYF(value);
                  }
                  break;
                case moveZ:
                  {
                    movementZF(value);
                  }
                  break;
              }
            },
          );
          
          await characters.setNotifyValue(true);
        }
      });
    }
  });

}
