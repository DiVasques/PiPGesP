// base_model.dart
import 'package:flutter/material.dart';
import 'package:pipgesp/services/authentication_services.dart';
import 'package:pipgesp/services/models/authentication_result.dart';

/// Represents the state of the view
enum ViewState { idle, busy, error }
enum LoginState { login, signUp, forgotPassword }

class LoginController extends ChangeNotifier {
  LoginState _loginState = LoginState.login;
  ViewState _state = ViewState.idle;
  String _errorMessage = '';

  LoginState get loginState => _loginState;
  set loginState(LoginState loginState) {
    _loginState = loginState;
    notifyListeners();
  }

  ViewState get state => _state;
  String get errorMessage => _errorMessage;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  String? _uid;
  String? _name;
  String? _phoneNumber;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _registration;
  String? _resetPasswordEmail;

  String? get uid => _uid;
  String? get name => _name;
  String? get phoneNumber => _phoneNumber;
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

  set phoneNumber(value) {
    _phoneNumber = value;
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
    _phoneNumber = null;
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

  Future<AuthenticationResult> handleSignInSignUp() async {
    if (_validateAndSaveFields()) {
      // set view as busy, so it shows a loading indicator
      setState(ViewState.busy);
      if (_loginState == LoginState.login) {
        AuthenticationResult authResult =
            await AuthenticationServices.emailSingIn(_email, _password);

        debugPrint("Status: ${authResult.status.toString()}");
        debugPrint("Error Code: ${authResult.errorCode.toString()}");
        debugPrint("Error Message: ${authResult.errorMessage.toString()}");

        if (authResult.status) {
          // DocumentSnapshot snapshot = await FirestoreHandler.getUser(
          //   departamento: User.departamento, empresa: User.empresa
          // );

          //debugPrint('Nome: ${User.displayName}, UID: ${User.uid}');
        }

        setState(ViewState.idle);
        return authResult;
      } else if (_loginState == LoginState.signUp) {
        //AuthenticationResult authResult = await AuthenticationServices.emailSignUp(_password);

        // AuthenticationResult authResult =
        //     await AuthenticationServices.emailSignUp(
        //   name: _name,
        //   registration: _registration,
        //   email: _email,
        //   password: _password,
        // );

        // setState(ViewState.idle);
        // return authResult;
      }
    }
    return AuthenticationResult(status: false, errorCode: "INV_INPUTS");
  }
}
