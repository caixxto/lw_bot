import 'package:flutter/cupertino.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String login;
  final String password;
  LoginButtonPressed(this.login, this.password);
}

class DataChanged extends LoginEvent {}