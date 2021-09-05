import 'package:flutter_blue/flutter_blue.dart';

const String battery = '180f';
const String rssi = '181c';
const String movmentX = '1820';
const String movmentY = '1821';
const String movmentZ = '1822';

createNotifiction(BluetoothDevice device, Function rssiF, Function batteryF,
    Function movementXF, Function movementYF, Function movementZF) async {
  List<BluetoothService> services = await device.discoverServices();
  List<BluetoothCharacteristic> c;
  List<String> uuidList = [battery, rssi, movmentX, movmentY, movmentZ];

  services.forEach((service) {
    var chars = service.uuid.toString().substring(4, 8);
    if (uuidList.contains(chars)) {
      c = service.characteristics;
      c.forEach((characters) async {
        if (characters.properties.notify) {
          characters.value.listen(
            (value) {
              switch (chars) {
                case rssi:
                  {
                    rssiF(value);
                  }
                  break;
                case battery:
                  {
                    batteryF(value);
                  }
                  break;
                case movmentX:
                  {
                    movementXF(value);
                  }
                  break;
                case movmentY:
                  {
                    movementYF(value);
                  }
                  break;
                case movmentZ:
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
