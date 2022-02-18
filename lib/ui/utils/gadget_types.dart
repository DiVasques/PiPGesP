enum GadgetType { input, output, spi }
extension StringExtension on GadgetType {
  String translatedValue() {
    switch (this) {
      case GadgetType.input:
        return 'Entrada';
      case GadgetType.output:
        return 'Saída';
      case GadgetType.spi:
        return 'SPI';
    }
  }
}