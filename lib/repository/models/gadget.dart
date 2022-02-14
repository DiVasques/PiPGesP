import 'package:pipgesp/ui/utils/gadget_devices.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';

class Gadget {
  GadgetDevice device;
  GadgetType iotype;
  String name;
  int physicalPort;
  String id;
  Gadget({
    required this.device,
    required this.iotype,
    required this.name,
    required this.physicalPort,
    required this.id,
  });
}
