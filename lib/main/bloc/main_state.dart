import 'package:flutter_html/flutter_html.dart';
import 'package:lw/accounts/acc_manager.dart';

abstract class MainState {}

class InitialState extends MainState {}

class UpdateScreen extends MainState {
  final List<Account> accounts;
  final bool check;
  final String status;
  UpdateScreen(this.accounts, this.check, this.status);
}

class UpdateData extends MainState {
  final List<Account> accounts;
  final AccountData accountData;
  final bool check;

  UpdateData(this.accountData, this.accounts, this.check);
}

class ErrorState extends MainState {
  final String e;
  ErrorState(this.e);
}