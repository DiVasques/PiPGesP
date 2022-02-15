// base_model.dart
import 'package:pipgesp/repository/home_repository.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/repository/models/user.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/utils/gadget_devices.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';

class HomeController extends BaseController {
  final String email;
  HomeController({required this.email}) {
    getUser();
  }

  final HomeRepository _homeRepository = HomeRepository();
  User get user => _homeRepository.user;

  Future<void> getUser() async {
    setState(ViewState.busy);
    Result result = await _homeRepository.getUser(email: email);

    if (result.status) {
      setState(ViewState.idle);
    } else {
      setErrorMessage(result.errorMessage!);
      setState(ViewState.error);
    }
  }

  Future<bool> addGadget() async {
    setState(ViewState.busy);
    Gadget gadget = Gadget(
        device: GadgetDevice.lamp,
        iotype: GadgetType.output,
        name: "lâmpada sala",
        physicalPort: 5,
        id: 'adadafafaf');
    Result result =
        await _homeRepository.addGadget(identifier: user.email, gadget: gadget);
    if (result.status) {
      await getUser();
    } else {
      setErrorMessage(result.errorMessage!);
      setState(ViewState.error);
    }
    return result.status;
  }
}
