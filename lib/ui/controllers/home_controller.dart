// base_model.dart
import 'package:flutter/foundation.dart';
import 'package:pipgesp/repository/home_repository.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/repository/models/user.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';

class HomeController extends BaseController {
  final String email;
  HomeController({required this.email}) {
    getUser();
  }

  final HomeRepository _homeRepository = HomeRepository();
  User get user => _homeRepository.user;

  Future<void> getUser() async {
    debugPrint(runtimeType.toString() + ".state: getUser");
    setState(ViewState.busy);
    Result result = await _homeRepository.getUser(email: email);

    if (result.status) {
      setState(ViewState.idle);
    } else {
      setErrorMessage(result.errorMessage ?? '');
      setState(ViewState.error);
    }
  }

  Future<bool> deleteGadget(String identifier, Gadget gadget) async {
    debugPrint(runtimeType.toString() + ".state: deleteGadget");
    setState(ViewState.busy);
    Result result = await _homeRepository.deleteGadget(
        identifier: identifier, gadget: gadget);
    if (!result.status) {
      setErrorMessage(result.errorMessage ?? '');
      setState(ViewState.idle);
    } else {
      getUser();
    }
    return result.status;
  }

  Future<bool> deleteAllGadgets() async {
    debugPrint(runtimeType.toString() + ".state: deleteGadget");
    setState(ViewState.busy);
    Result result =
        await _homeRepository.deleteAllGadgets(identifier: user.raspberryIP);
    if (!result.status) {
      setErrorMessage(result.errorMessage ?? '');
      setState(ViewState.idle);
    } else {
      getUser();
    }
    return result.status;
  }
}
