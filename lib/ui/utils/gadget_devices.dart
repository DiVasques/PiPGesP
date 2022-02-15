enum GadgetDevice { lamp, decoupler, thermometer }
extension StringExtension on GadgetDevice {
  String toValueString() {
    switch (this) {
      case GadgetDevice.lamp:
        return 'lamp';
      case GadgetDevice.decoupler:
        return 'decoupler';
      case GadgetDevice.thermometer:
        return 'thermometer';
    }
  }
}
