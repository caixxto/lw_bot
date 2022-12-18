import 'package:flutter/cupertino.dart';

class Account {
  int? id;
  final String login;
  final String password;

  Account({this.id, required this.login, required this.password});
}

class AccountData {
  final Account account;
  final int passes;
  final int equus;
  final int or;
  final List<BlackMarket> market;
  AccountData({required this.account, required this.passes, required this.equus, required this.or, required this.market});
}

class BlackMarket {
  final String name;
  final String image;
  final int count;
  BlackMarket(this.name, this.image, this.count);
}

class BlackMarketRepository {
  static final BlackMarketRepository  _instance = BlackMarketRepository._();

  BlackMarketRepository._();

  static BlackMarketRepository get instance => _instance;

  final List<BlackMarket> _list = List.empty(growable: true);
  // final List<BlackMarket> _list = [
  //   BlackMarket('Папирус Плутоса', 'parchemin-ploutos', 'https://www.lowadi.com/media/equideo/image/produits/32/parchemin-ploutos.png'),
  // ];

  List<BlackMarket> get getBlackMarket => _list;

  void addNewItem(BlackMarket blackMarket) => _list.add(blackMarket);

}

class AccountRepository {
  static final AccountRepository  _instance = AccountRepository._();

  AccountRepository._();

  static AccountRepository get instance => _instance;

  final List<Account> _list = List.empty(growable: true);
  // final List<Account> _list = [
  //   Account(login: 'Пьеро', password: 'неудаляйтеакк'),
  //   Account(login: 'Лаймишь', password: 'VzJURxMYqc'),
  //   Account(login: 'Карфина', password: '13h81Tc'),
  //   Account(login: 'Lira Mira', password: 'HhJBkx0'),
  //   Account(login: 'Зелёная стрела', password: 'SiOiJKGqF'),
  // ];

  List<Account> get getAccounts => _list;

  void addNewAccount(Account account) => _list.add(account);

  void deleteAccount(int index) => _list.removeAt(index);

}

class AccountDataRepository {
  static final AccountDataRepository  _instance = AccountDataRepository._();

  AccountDataRepository._();

  static AccountDataRepository get instance => _instance;

  final List<AccountData> _list = List.empty(growable: true);
  // final List<Account> _list = [
  //   Account(login: 'caixxto', password: 'ubatcha'),
  // ];

  List<AccountData> get getAccountsData => _list;

  void addNewData(AccountData accountData) => _list.add(accountData);

}