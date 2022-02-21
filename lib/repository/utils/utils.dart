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

  static GadgetDevice processDevice(String deviceString) {
    GadgetDevice gadgetDevice = GadgetDevice.values.firstWhere(
      (device) => device.name == deviceString.toLowerCase(),
      orElse: () => GadgetDevice.other,
    );
    return gadgetDevice;
  }

  static DataType processDataType(String dataTypeString) {
    DataType dataType = DataType.values.firstWhere(
      (type) => type.name == dataTypeString.toLowerCase(),
      orElse: () => DataType.string,
    );
    return dataType;
  }
}
