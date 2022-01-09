///Define validators for a variety of Text Fields, returns
///`null` if the input is valid or the corresponding error message as a `String`
class FieldValidators {
  static String requiredEmailDomain = ''; // Leave empty for testing

  static String? validateEmail(String? input) {
    input!.trim();
    String regexString =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@poli.ufrj.br";
    RegExp validEmailPattern = RegExp(regexString);
    RegExp requiredEmailPattern = RegExp('$requiredEmailDomain\$');
    if (validEmailPattern.hasMatch(input)) {
      if (requiredEmailPattern.hasMatch(input) || requiredEmailDomain == '') {
        return null;
      } else {
        return 'Email dever pertencer ao domínio $requiredEmailDomain';
      }
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
  
  static String? validateRegistration(String? input){
    int matriculaLenght = input!.length;
    if(matriculaLenght < 9){
      return 'Insira uma matricula';
    } else {
      return null;
  }
  }

  static String? validatePwdsMatch(String? confirmPwd, String? pwd) {
    if (confirmPwd != pwd) return 'Senhas devem ser iguais';
    return null;
  }
}
