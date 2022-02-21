enum GadgetDevice { lamp, other, thermometer }

extension StringExtension on GadgetDevice {
  String translatedValue() {
    switch (this) {
      case GadgetDevice.lamp:
        return 'Lâmpada';
      case GadgetDevice.other:
        return 'Outro';
      case GadgetDevice.thermometer:
        return 'Termômetro';
    }
  }
}
