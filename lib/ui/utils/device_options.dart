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
  static const List<String> ioPorts = ['1','2','3','4','5','6','7'];
  static const List<String> spiPorts = ['999'];
}
