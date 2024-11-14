abstract class AuthEvent {}

class LoginRequestEvent extends AuthEvent{
  String username;
  String password;
  LoginRequestEvent(this.username,this.password);
}