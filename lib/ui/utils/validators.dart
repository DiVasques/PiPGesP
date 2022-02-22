///Define validators for a variety of Text Fields, returns
///`null` if the input is valid or the corresponding error message as a `String`
class FieldValidators {
  static String? validateEmail(String? input) {
    input!.trim();
    String regexString = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[\w]+.ufrj.br$";
    RegExp validEmailPattern = RegExp(regexString);
    if (validEmailPattern.hasMatch(input)) {
      return null;
    } else {
      return 'E-mail Inválido';
    }
  }

  static String? validatePwd(String? input) {
    int pwdLenght = input!.length;
    if (pwdLenght < 6 || pwdLenght > 12) {
      return 'Senha deve ter entre 6 e 12 caracteres';
    } else {
      return null;
    }
  }

  static String? validateRegistration(String? input) {
    input!.trim();
    RegExp validRegistrationPattern = RegExp(r"^[0-9]{9}");
    if (validRegistrationPattern.hasMatch(input) && input.length == 9) {
      return null;
    } else {
      return 'Matrícula Inválida';
    }
  }

  static String? validatePwdsMatch(String? confirmPwd, String? pwd) {
    if (confirmPwd != pwd) return 'Senhas devem ser iguais';
    return null;
  }

  static String? validateName(String? input) {
    input!.trim();
    RegExp validRegistrationPattern = RegExp(r"^[a-zA-Z0-9 À-ÿ]+$");
    if (validRegistrationPattern.hasMatch(input) && input.length <= 20) {
      return null;
    } else {
      return 'Nome de dispositivo inválido';
    }
  }

  static String? validateIP(String? input) {
    input!.trim();
    RegExp validRegistrationPattern =
        RegExp(r"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}$");
    if (validRegistrationPattern.hasMatch(input)) {
      return null;
    } else {
      return 'Endereço de IP inválido';
    }
  }

  static String? validateNotEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }
}
