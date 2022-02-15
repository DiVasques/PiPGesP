enum GadgetType { input, output, serial }
extension StringExtension on GadgetType {
  String toValueString() {
    switch (this) {
      case GadgetType.input:
        return 'Entrada';
      case GadgetType.output:
        return 'Saída';
      case GadgetType.serial:
        return 'Serial';
    }
  }
  String toValue() {
    switch (this) {
      case GadgetType.input:
        return 'input';
      case GadgetType.output:
        return 'output';
      case GadgetType.serial:
        return 'serial';
    }
  }
}