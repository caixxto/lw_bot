class Account {
  int? id;
  final String login;
  final String password;

  Account({this.id, required this.login, required this.password});
}

class AccountRepository {
  static final AccountRepository  _instance = AccountRepository._();

  AccountRepository._();

  static AccountRepository get instance => _instance;

  final List<Account> _list = List.empty(growable: true);
  // final List<Account> _list = [
  //   Account(login: 'dusk till dawn', password: 'ctmiuq'),
  // ];

  List<Account> get getAccounts => _list;

  void addNewAccount(Account account) => _list.add(account);

}