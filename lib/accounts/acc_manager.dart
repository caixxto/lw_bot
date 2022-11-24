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

  //final List<Account> _list = List.empty(growable: true);
  final List<Account> _list = [
    Account(login: 'Reyunnokzh', password: 'Zheanapsas'),
    Account(login: 'Kentines', password: 'zvXqQHjiDD'),
    Account(login: 'Nalesbavap', password: 'HailHail'),
    Account(login: 'НиколайБасков', password: 'вечером не ходи'),
    Account(login: 'Pryce', password: 'JJDPY3XgnF'),
    Account(login: 'Katabvobak', password: 'KaanKaan'),
    Account(login: 'Between Two', password: 'starsthatitbuilds'),
    Account(login: 'Shooting', password: 'theysayitgtscldr'),
    Account(login: 'Sudden Attraction', password: 'mindthatdistracts'),
    Account(login: 'Туманник', password: 'ypdoeh'),

  ];

  List<Account> get getAccounts => _list;

  void addNewAccount(Account account) => _list.add(account);

}