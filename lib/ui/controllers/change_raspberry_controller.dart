import 'package:flutter/material.dart';
import 'package:pipgesp/repository/change_raspberry_repository.dart';
import 'package:pipgesp/repository/models/user.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';

class ChangeRaspberryController extends BaseController {
  final User user;
  ChangeRaspberryController({required this.user});

  final ChangeRaspberryRepository _changeRaspberryRepository =
      ChangeRaspberryRepository();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  String? _raspberryIP;

  String? get raspberryIP => _raspberryIP;

  set raspberryIP(value) {
    _raspberryIP = value;
    notifyListeners();
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

  Future<bool?> changeRaspberry() async {
    debugPrint(runtimeType.toString() + ".state: changeRaspberry");
    if (_validateAndSaveFields()) {
      setState(ViewState.busy);
      Result result = await _changeRaspberryRepository.changeRaspberry(
        raspberryIP: raspberryIP!,
        email: user.email,
      );
      if (!result.status) {
        setErrorMessage(result.errorMessage ?? '');
        setState(ViewState.idle);
      }
      return result.status;
    }
    return null;
  }
}
