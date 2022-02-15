// base_model.dart
import 'package:pipgesp/repository/gadget_repository.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/repository/models/gadget_data.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/utils/data_types.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';

class GadgetController extends BaseController {
  final int physicalPort;
  GadgetController({required this.physicalPort}) {
    getGadgetData();
  }

  bool _outputFormValue = false;
  bool get outputFormValue => _outputFormValue;
  set outputFormValue(bool outputValue) {
    _outputFormValue = outputValue;
    notifyListeners();
  }

  final GadgetRepository _gadgetRepository = GadgetRepository();
  GadgetData get gadgetData => _gadgetRepository.gadgetData;

  Future<void> getGadgetData() async {
    setState(ViewState.busy);
    Result result =
        await _gadgetRepository.getGadgetData(physicalPort: physicalPort);

    if (result.status) {
      if (gadgetData.iotype == GadgetType.output &&
          gadgetData.dataType == DataType.bool) {
        outputFormValue = gadgetData.data as bool;
      }
      setState(ViewState.idle);
    } else {
      setErrorMessage(result.errorMessage!);
      setState(ViewState.error);
    }
  }

  Future<void> setGadgetOutput(bool value) async {
    setState(ViewState.busy);
    Result result = await _gadgetRepository.setGadgetOutput(
        physicalPort: physicalPort, output: value);
    if (result.status) {
      outputFormValue = value;
      setState(ViewState.idle);
    } else {
      setErrorMessage(result.errorMessage!);
      setState(ViewState.error);
    }
  }

  Future<bool> deleteGadget(String identifier, Gadget gadget) async {
    setState(ViewState.busy);
    Result result = await _gadgetRepository.deleteGadget(
        identifier: identifier, gadget: gadget);
    if (!result.status) {
      setErrorMessage(result.errorMessage!);
      setState(ViewState.error);
    }
    return result.status;
  }
}
