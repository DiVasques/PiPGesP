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
      case 'serial':
        return GadgetType.serial;

      default:
        return GadgetType.input;
    }
  }

  static GadgetDevice processDevice(String device) {
    switch (device) {
      case 'lamp':
        return GadgetDevice.lamp;
      case 'decoupler':
        return GadgetDevice.decoupler;
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
      case 'float':
        return DataType.float;

      default:
        return DataType.string;
    }
  }
}
