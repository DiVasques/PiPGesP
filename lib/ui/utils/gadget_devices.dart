enum GadgetDevice { lamp, relay, thermometer }
extension StringExtension on GadgetDevice {
  String toValueString() {
    switch (this) {
      case GadgetDevice.lamp:
        return 'lamp';
      case GadgetDevice.relay:
        return 'relay';
      case GadgetDevice.thermometer:
        return 'thermometer';
    }
  }
}
