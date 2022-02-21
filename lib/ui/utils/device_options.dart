import 'package:pipgesp/ui/utils/gadget_devices.dart';

class DeviceOptions {
  static const List<GadgetDevice> inputOptions = [
    GadgetDevice.lamp,
    GadgetDevice.relay
  ];
  static const List<GadgetDevice> outputOptions = [
    GadgetDevice.lamp,
    GadgetDevice.relay
  ];
  static const List<GadgetDevice> spiOptions = [
    GadgetDevice.thermometer,
  ];
  static const List<String> ioPorts = [
    '7',
    '11',
    '12',
    '13',
    '15',
    '16',
    '18',
    '22',
    '29',
    '31',
    '32',
    '33',
    '35',
    '36',
    '37',
    '38',
    '40'
  ];
  static const List<String> spiPorts = ['999'];
}
