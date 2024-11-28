abstract class AuthEvent {}

class LoginRequestEvent extends AuthEvent {
  String username;
  String password;
  LoginRequestEvent(this.username, this.password);
}

class RegisterRequestEvent extends AuthEvent {
  final String username;
  final String password;
  final String passwordConfirm;

  RegisterRequestEvent(this.username, this.password, this.passwordConfirm);
}
