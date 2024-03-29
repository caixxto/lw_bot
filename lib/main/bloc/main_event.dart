abstract class MainEvent {}

class DataChanged extends MainEvent {}

class AddNewAccount extends MainEvent {
  final String login;
  final String password;
  AddNewAccount(this.login, this.password);
}

class Lug extends MainEvent {}

class Lug2 extends MainEvent {}

class ParseData extends MainEvent {}

class SaveDataExcel extends MainEvent {}

class OpenList extends MainEvent {}

class ChangeAccount extends MainEvent {
  final int id;
  ChangeAccount(this.id);
}

class DeleteAccount extends MainEvent {}

class BuyHorses extends MainEvent {
  final int pause;
  BuyHorses(this.pause);
}