enum GadgetDevice { lamp, relay, thermometer }

extension StringExtension on GadgetDevice {
  String translatedValue() {
    switch (this) {
      case GadgetDevice.lamp:
        return 'Lâmpada';
      case GadgetDevice.relay:
        return 'Relé';
      case GadgetDevice.thermometer:
        return 'Termômetro';
    }
  }
}
