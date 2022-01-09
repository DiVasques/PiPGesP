class AuthenticationResult {
  late bool status;
  late String? errorCode;
  late String? errorMessage;
  AuthenticationResult({
    required this.status,
    this.errorCode,
    this.errorMessage,
  });
}
