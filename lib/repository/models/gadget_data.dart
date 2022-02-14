import 'package:pipgesp/ui/utils/data_types.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';

class GadgetData {
  GadgetType iotype;
  String name;
  DataType dataType;
  DateTime lastChange;
  Object data;
  GadgetData({
    required this.iotype,
    required this.name,
    required this.dataType,
    required this.lastChange,
    required this.data,
  });
}
