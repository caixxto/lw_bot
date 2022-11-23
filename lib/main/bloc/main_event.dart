abstract class MainEvent {}

class DataChanged extends MainEvent {}

class AddNewAccount extends MainEvent {
  final String login;
  final String password;
  AddNewAccount(this.login, this.password);
}

class Lug extends MainEvent {}

class Lug2 extends MainEvent {}