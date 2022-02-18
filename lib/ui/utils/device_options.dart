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
}
