// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/controllers/login_controller.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:pipgesp/ui/widgets/default_text_field.dart';
import 'package:pipgesp/ui/utils/app_colors.dart';
import 'package:pipgesp/ui/utils/dimensions.dart';
import 'package:pipgesp/ui/utils/validators.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  late FocusNode _nameFocus;
  late FocusNode _phoneNumberFocus;
  late FocusNode _registrationFocus;
  late FocusNode _raspberryIPFocus;
  late FocusNode _confirmPasswordFocus;
  late FocusNode _resetPasswordFocus;
  static const TextStyle style = TextStyle(fontSize: 20.0);

  final String EMAIL_NOT_FOUND = 'user-not-found';
  final String ERROR_WRONG_PASSWORD = 'wrong-password';
  final String ERROR_EMAIL_ALREADY_USE = 'email-already-in-use';

  @override
  void initState() {
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _nameFocus = FocusNode();
    _phoneNumberFocus = FocusNode();
    _registrationFocus = FocusNode();
    _raspberryIPFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
    _resetPasswordFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _nameFocus.dispose();
    _phoneNumberFocus.dispose();
    _registrationFocus.dispose();
    _raspberryIPFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>(
      create: (_) => LoginController(),
      child: Consumer<LoginController>(builder: (context, loginController, _) {
        return Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight
              ],
            ),
          ),
          child: WillPopScope(
            onWillPop: () async {
              if (loginController.loginState != LoginState.login) {
                loginController.loginState = LoginState.login;
                return false;
              } else {
                return true;
              }
            },
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
              ),
              child: Scaffold(
                backgroundColor: AppColors.detailsScreensBackground,
                body: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.toppadding * 2,
                            left: Dimensions.sidePadding,
                            right: Dimensions.sidePadding),
                        child: Form(
                          key: loginController.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Image(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  'assets/images/logo_del.png',
                                ),
                              ),
                              Dimensions.heightSpacer(
                                  Dimensions.inBetweenItensPadding * 2.5),
                              Card(
                                elevation: 5,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: Dimensions.screenHeight(context) *
                                          0.06,
                                      width: Dimensions.screenWidth(context),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Text(
                                              loginController.loginState ==
                                                      LoginState.login
                                                  ? 'Login'
                                                  : loginController
                                                              .loginState ==
                                                          LoginState.signUp
                                                      ? 'Cadastrar'
                                                      : 'Redefinir Senha',
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: SizedBox(
                                          height:
                                              Dimensions.screenHeight(context) *
                                                  0.01),
                                    ),
                                    Column(
                                      children: _buildInputs(
                                          loginController, context),
                                    ),
                                    loginController.loginState ==
                                            LoginState.login
                                        ? SizedBox(
                                            height: Dimensions.screenHeight(
                                                    context) *
                                                0.05,
                                            width: Dimensions.screenWidth(
                                                    context) /
                                                0.12,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: TextButton(
                                                        onPressed: () {
                                                          loginController
                                                                  .loginState =
                                                              LoginState
                                                                  .forgotPassword;
                                                        },
                                                        child: Text(
                                                            "Esqueceu sua Senha?",
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                            textAlign:
                                                                TextAlign.end)),
                                                  ),
                                                ]),
                                          )
                                        : Dimensions.heightSpacer(
                                            Dimensions.screenHeight(context) *
                                                0.01),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    Dimensions.screenHeight(context) * 0.015,
                              ),
                              ..._buildButtons(loginController, context),
                            ],
                          ),
                        ),
                      ),
                    ),
                    loginController.loginState == LoginState.login
                        ? Container()
                        : SafeArea(
                            child: Container(
                              alignment: Alignment.topLeft,
                              color: Colors.transparent,
                              height: 46,
                              width: 46,
                              child: IconButton(
                                color: Colors.grey[600],
                                onPressed: () {
                                  loginController.loginState = LoginState.login;
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _buildInputs(
      LoginController loginController, BuildContext context) {
    List<Widget> emailPasswordInputs = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          labelText: 'Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FieldValidators.validateEmail,
          onSaved: (value) => loginController.email = value,
          focusNode: _emailFocus,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          obscureText: true,
          labelText: 'Senha',
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: FieldValidators.validatePwd,
          onSaved: (value) => loginController.password = value,
          focusNode: _passwordFocus,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            if (loginController.loginState == LoginState.login) {
              _signInSignUp(loginController);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
        ),
      ),
    ];

    List<Widget> signUpInputs = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          labelText: 'Nome',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onSaved: (value) => loginController.name = value,
          focusNode: _nameFocus,
          validator: FieldValidators.validateName,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_emailFocus);
          },
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          labelText: 'Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FieldValidators.validateEmail,
          onSaved: (value) => loginController.email = value,
          focusNode: _emailFocus,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_registrationFocus);
          },
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          labelText: 'DRE',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: FieldValidators.validateRegistration,
          onSaved: (value) => loginController.registration = value,
          focusNode: _registrationFocus,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_raspberryIPFocus);
          },
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          labelText: 'IP do Raspberry',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: FieldValidators.validateIP,
          onSaved: (value) => loginController.raspberryIP = value,
          focusNode: _raspberryIPFocus,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          style: style,
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.next,
          obscureText: true,
          focusNode: _passwordFocus,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_confirmPasswordFocus);
          },
          controller: _pass,
          validator: FieldValidators.validatePwd,
          onSaved: (value) => loginController.password = value,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: 'Senha',
            fillColor: Colors.white,
            filled: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            errorStyle: const TextStyle(fontSize: 11.0),
          ),
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          style: style,
          textAlign: TextAlign.start,
          obscureText: true,
          focusNode: _confirmPasswordFocus,
          controller: _confirmPass,
          onSaved: (value) => loginController.confirmPassword = value,
          validator: (val) {
            if (FieldValidators.validatePwd(val) != null) {
              return 'Senha deve ter entre 6 e 12 caracteres';
            }
            if (val != _pass.text) return 'Senhas n??o s??o iguais';
            return null;
          },
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            _signInSignUp(loginController);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: 'Confirmar Senha',
            fillColor: Colors.white,
            filled: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            errorStyle: const TextStyle(fontSize: 11.0),
          ),
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
    ];

    List<Widget> resetPasswordInput() {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            style: style,
            textAlign: TextAlign.start,
            focusNode: _resetPasswordFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
              _resetPassword(loginController);
            },
            validator: FieldValidators.validateEmail,
            onSaved: (value) => loginController.resetPasswordEmail = value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Email',
              fillColor: Colors.white,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              errorStyle: const TextStyle(fontSize: 11.0),
            ),
          ),
        ),
        Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      ];
    }

    return loginController.loginState == LoginState.login
        ? emailPasswordInputs
        : loginController.loginState == LoginState.signUp
            ? [
                Dimensions.heightSpacer(
                    Dimensions.screenHeight(context) * 0.01),
                ...signUpInputs
              ]
            : resetPasswordInput();
  }

  List<Widget> _buildButtons(
      LoginController loginController, BuildContext context) {
    Material signButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(8.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        onPressed: loginController.loginState == LoginState.forgotPassword
            ? () async {
                FocusScope.of(context).unfocus();
                _resetPassword(loginController);
              }
            : () async {
                FocusScope.of(context).unfocus();
                _signInSignUp(loginController);
              },
        child: loginController.state == ViewState.idle
            ? Text(
                loginController.loginState == LoginState.login
                    ? "Entrar"
                    : loginController.loginState == LoginState.signUp
                        ? "Cadastrar"
                        : "Enviar Email",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : SizedBox(
                height: Dimensions.screenHeight(context) * 0.04,
                width: Dimensions.screenHeight(context) * 0.04,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
      ),
    );

    if (loginController.loginState == LoginState.login) {
      return [
        //Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.02),
        SizedBox(
          height: Dimensions.screenHeight(context) * 0.07,
          width: Dimensions.screenWidth(context) / 0.15,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: signButton,
          ),
        ),
        Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.005),
        SizedBox(
          height: Dimensions.screenHeight(context) * 0.09,
          width: Dimensions.screenWidth(context) / 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'N??o tem uma conta?',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              TextButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  loginController.loginState = LoginState.signUp;
                },
                child: Text(
                  "Inscreva-se",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
        Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.02),
        Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
        Dimensions.heightSpacer(Dimensions.inBetweenItensPadding * 2),
      ];
    } else {
      return [
        Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
        SizedBox(
          //alignment: Alignment.centerRight,
          height: Dimensions.screenHeight(context) * 0.07,
          width: Dimensions.screenWidth(context) / 0.15,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: signButton,
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ];
    }
  }

  void _signInSignUp(LoginController loginController) {
    loginController.handleSignInSignUp().then(
      (result) {
        if (!result.status && result.errorCode == "INV_INPUTS") {
          _showDialog(loginController);
        } else if (result.status) {
          if (loginController.loginState == LoginState.signUp) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _buildErrorDialog(context, loginController, result);
                });

            // Can't login automatically after creating account because the email should be confirmed
            loginController.loginState = LoginState.login;
          } else if (loginController.loginState == LoginState.login) {
            // Go to home screen
            Navigator.pushNamedAndRemoveUntil(context, GenericRouter.homeRoute,
                (Route<dynamic> route) => false,
                arguments: loginController.email);
          }
        } else if (!result.status) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _buildErrorDialog(context, loginController, result);
            },
          );
        }
      },
    );
  }

  void _resetPassword(LoginController loginController) {
    loginController.resetPassword().then((result) {
      if (!result.status && result.errorCode == "INV_INPUTS") {
        _showDialog(loginController);
      } else if (result.status) {
        loginController.loginState = LoginState.login;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                "Siga as instru????es contidas no email enviado para o endere??o ${loginController.resetPasswordEmail} para redefinir sua senha.",
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // retorna um objeto do tipo Dialog
            return AlertDialog(
              content: result.errorCode == EMAIL_NOT_FOUND
                  ? const Text(
                      "O endere??o de email inserido n??o esta cadastrado na plataforma")
                  : const Text(
                      "Ocorreu um erro na opera????o. Tente novamente mais tarde."),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _showDialog(LoginController loginController) {
    loginController.handleSignInSignUp().then((result) {
      if (!result.status && result.errorCode == "INV_INPUTS") {
        return null;
      } else if (result.status) {
        Navigator.pushReplacementNamed(context, GenericRouter.homeRoute);
      } else if (!result.status) {
        debugPrint(result.errorCode);
      }
      debugPrint(result.errorMessage);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // retorna um objeto do tipo Dialog
          return AlertDialog(
            title: const Text("Alert Dialog titulo"),
            content: const Text("Alert Dialog body"),
            actions: <Widget>[
              // define os bot??es na base do dialogo
              TextButton(
                child: const Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  Widget _buildErrorDialog(
      BuildContext context, LoginController loginController, Result result) {
    List<Widget> buttons = [];
    String? message = '';

    if (result.errorCode == 'ERROR_EMAIL_NOT_VERIFIED' ||
        result.errorCode == ERROR_EMAIL_ALREADY_USE) {
      if (result.errorCode == ERROR_EMAIL_ALREADY_USE) {
        message = 'Email j?? registrado. ';
      }
      message +=
          'Acesse o link enviado para o email cadastrado para confirmar sua conta.';
      buttons.add(
        TextButton(
          child: const Text("Reenviar"),
          onPressed: () async {
            await loginController.resendVerificationEmail();
            Navigator.pop(context);
          },
        ),
      );
    } else if (result.errorCode == EMAIL_NOT_FOUND ||
        result.errorCode == ERROR_WRONG_PASSWORD) {
      message = 'Usu??rio e/ou senha incorretos.';
    } else {
      message = result.errorMessage;
    }

    buttons.add(
      TextButton(
        child: const Text("Fechar"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );

    return AlertDialog(
      title: Center(
        child: result.errorCode == '201'
            ? const Text(
                "Alerta",
                style: TextStyle(color: Colors.grey),
              )
            : const Text("Erro", style: TextStyle(color: Colors.grey)),
      ),
      content: Text(
        "$message",
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      actions: buttons,
    );
  }
}
