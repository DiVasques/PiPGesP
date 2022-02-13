// base_model.dart
import 'package:pipgesp/repository/gadget_repository.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';

class GadgetController extends BaseController {
  final String id;
  GadgetController({required this.id}) {
    getGadgetData();
  }

  final GadgetRepository _gadgetRepository = GadgetRepository();

  Future<void> getGadgetData() async {
    setState(ViewState.busy);
    Result result = await _gadgetRepository.getGadgetData(id: id);

    if (result.status) {
      setState(ViewState.idle);
    } else {
      setErrorMessage(result.errorMessage!);
      setState(ViewState.error);
    }
  }
}
