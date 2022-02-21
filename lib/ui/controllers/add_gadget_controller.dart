import 'package:flutter/material.dart';
import 'package:pipgesp/repository/add_gadget_repository.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/repository/models/user.dart';
import 'package:pipgesp/repository/utils/utils.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/utils/device_options.dart';
import 'package:uuid/uuid.dart';

class AddGadgetController extends BaseController {
  final User user;
  AddGadgetController({required this.user});

  final AddGadgetRepository _addGadgetRepository = AddGadgetRepository();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  String? _name;
  String? _gadgetType = 'input';
  String? _gadgetDevice;
  String? _physicalPort;

  String? get name => _name;
  String? get gadgetType => _gadgetType;
  String? get gadgetDevice => _gadgetDevice;
  String? get physicalPort => _physicalPort;

  set name(value) {
    _name = value;
    notifyListeners();
  }

  set gadgetType(value) {
    _gadgetType = value;
    notifyListeners();
  }

  set gadgetDevice(value) {
    _gadgetDevice = value;
    notifyListeners();
  }

  set physicalPort(value) {
    _physicalPort = value;
    notifyListeners();
  }

  List<String> availableIOPorts() {
    List<String> availablePorts = [];
    availablePorts.addAll(DeviceOptions.ioPorts);
    for (Gadget gadget in user.gadgets) {
      availablePorts.remove(gadget.physicalPort.toString());
    }
    return availablePorts;
  }

  List<String> availableSPIPorts() {
    List<String> availablePorts = [];
    availablePorts.addAll(DeviceOptions.spiPorts);
    for (Gadget gadget in user.gadgets) {
      availablePorts.remove(gadget.physicalPort.toString());
    }
    return availablePorts;
  }

  bool _validateAndSaveFields() {
    final _formState = _formKey.currentState;
    if (_formState!.validate()) {
      _formState.save();
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> addGadget() async {
    debugPrint(runtimeType.toString() + ".state: addGadget");
    if (_validateAndSaveFields()) {
      setState(ViewState.busy);
      Uuid uuid = Uuid();
      String uid = uuid.v4();
      Gadget gadget = Gadget(
        device: Utils.processDevice(_gadgetDevice!),
        iotype: Utils.processIOType(_gadgetType!),
        name: _name!,
        physicalPort: int.parse(_physicalPort!),
        id: uid,
      );
      Result result = await _addGadgetRepository.addGadget(
        identifier: user.email,
        gadget: gadget,
      );
      if(!result.status) {
        setErrorMessage(result.errorMessage!);
      }
      setState(ViewState.idle);
      return result.status;
    }
    return null;
  }
}
