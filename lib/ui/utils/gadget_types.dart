enum GadgetType { input, output, spi }
extension StringExtension on GadgetType {
  String toValueString() {
    switch (this) {
      case GadgetType.input:
        return 'Entrada';
      case GadgetType.output:
        return 'Saída';
      case GadgetType.spi:
        return 'SPI';
    }
  }
  String toValue() {
    switch (this) {
      case GadgetType.input:
        return 'input';
      case GadgetType.output:
        return 'output';
      case GadgetType.spi:
        return 'spi';
    }
  }
}