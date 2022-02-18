import 'package:pipgesp/ui/utils/data_types.dart';
import 'package:pipgesp/ui/utils/gadget_devices.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';

class Utils {
  static GadgetType processIOType(String iotype) {
    switch (iotype) {
      case 'input':
        return GadgetType.input;
      case 'output':
        return GadgetType.output;
      case 'spi':
        return GadgetType.spi;

      default:
        return GadgetType.input;
    }
  }

  static GadgetDevice processDevice(String device) {
    switch (device) {
      case 'lamp':
        return GadgetDevice.lamp;
      case 'relay':
        return GadgetDevice.relay;
      case 'thermometer':
        return GadgetDevice.thermometer;

      default:
        return GadgetDevice.lamp;
    }
  }

  static DataType processDataType(String dataType) {
    switch (dataType) {
      case 'bool':
        return DataType.bool;
      case 'string':
        return DataType.string;
      case 'map':
        return DataType.map;
      case 'int':
        return DataType.int;

      default:
        return DataType.string;
    }
  }
}
