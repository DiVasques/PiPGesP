// base_model.dart
import 'package:flutter/material.dart';
import 'package:pipgesp/services/authentication_services.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';

/// Represents the state of the view
enum LoginState { login, signUp, forgotPassword }

class LoginController extends BaseController {
  LoginState _loginState = LoginState.login;

  LoginState get loginState => _loginState;
  set loginState(LoginState loginState) {
    _loginState = loginState;
    notifyListeners();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  String? _uid;
  String? _name;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _registration;
  String? _resetPasswordEmail;

  String? get uid => _uid;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  String? get confirmPassword => _confirmPassword;
  String? get registration => _registration;
  String? get resetPasswordEmail => _resetPasswordEmail;

  set uid(value) {
    _uid = value;
    notifyListeners();
  }

  set name(value) {
    _name = value;
    notifyListeners();
  }

  set email(value) {
    _email = value;
    notifyListeners();
  }

  set password(value) {
    _password = value;
    notifyListeners();
  }

  set confirmPassword(value) {
    _confirmPassword = value;
    notifyListeners();
  }

  set registration(value) {
    _registration = value;
    notifyListeners();
  }

  set resetPasswordEmail(value) {
    _resetPasswordEmail = value;
    notifyListeners();
  }

  void clearInputs() {
    _uid = null;
    _name = null;
    _email = null;
    _password = null;
    _confirmPassword = null;
    _registration = null;
    _resetPasswordEmail = null;
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

  Future<Result> handleSignInSignUp() async {
    debugPrint(runtimeType.toString()+".state: handleSignInSignUp");
    if (_validateAndSaveFields()) {
      // set view as busy, so it shows a loading indicator
      setState(ViewState.busy);
      if (_loginState == LoginState.login) {
        Result authResult =
            await AuthenticationServices.emailSingIn(_email, _password);

        debugPrint("Status: ${authResult.status.toString()}");
        debugPrint("Error Code: ${authResult.errorCode.toString()}");
        debugPrint("Error Message: ${authResult.errorMessage.toString()}");

        if (authResult.status) {
          debugPrint('Logged in as $email');
        }

        setState(ViewState.idle);
        return authResult;
      } else if (_loginState == LoginState.signUp) {
        Result authResult =
            await AuthenticationServices.emailSignUp(
          email: email!,
          name: name!,
          password: password!,
          registration: registration!,
        );

        debugPrint("Status: ${authResult.status.toString()}");
        debugPrint("Error Code: ${authResult.errorCode.toString()}");
        debugPrint("Error Message: ${authResult.errorMessage.toString()}");

        setState(ViewState.idle);
        return authResult;
      }
    }
    return Result(status: false, errorCode: "INV_INPUTS");
  }

  Future<void> resendVerificationEmail() async {
    debugPrint(runtimeType.toString()+".state: resendVerificationEmail");
    await AuthenticationServices.sendVerificationEmail(email: _email!, password: _password!);
  }

  Future<Result> resetPassword() async {
    debugPrint(runtimeType.toString()+".state: resetPassword");
    if (_validateAndSaveFields()) {
      setState(ViewState.busy);
      Result result = await AuthenticationServices.resetPassword(
          email: _resetPasswordEmail!);

      setState(ViewState.idle);
      return result;
    }
    return Result(status: false, errorCode: "INV_INPUTS");
  }
}
