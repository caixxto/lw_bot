import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:lw/accounts/acc_manager.dart';
import 'package:lw/main/bloc/main_event.dart';
import 'package:lw/main/bloc/main_state.dart';
import 'package:lw/network.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AccountRepository _repository = AccountRepository.instance;
  final List<String> ids = [];
  final List<String> skip = [];

  MainBloc() : super(InitialState()) {
    _initState();

    on<DataChanged>((event, state) async {
      // _sendRequest();
    });

    on<AddNewAccount>(_addNewAccount);

    on<Lug>((event, state) async {
      for (var i = 0; i < _repository.getAccounts.length; i++) {
        final account = _repository.getAccounts;
        var exp = true;
        var numRetries = 0;

        do {
          if (exp) {
            print('Попытка входа ${account[i].login}');
            exp = await _loginRequest(account[i].login, account[i].password);
            numRetries++;
          } else {
            _updateScreen(false, 'Вход выполнен ${account[i].login}');
            print('Вход выполнен ${account[i].login}');
          }
        } while ((exp) && (numRetries < 5));

        if (exp == false) {
          await _collectSkinRequest();
          await _sellSkinRequest();
          await _setSkinRequest();
          await _logoutRequest();
        } else {
          skip.add(account[i].login);
        }
        print('Пропущенные аккаунты: $skip');
      }
    });
  }

  Future<void> _initState() async {
    _updateScreen(false, '');
  }

  void _updateScreen(check, status) {
    emit(UpdateScreen(_repository.getAccounts, check, status));
  }

  void _addNewAccount(AddNewAccount event, Emitter<MainState> state) async {
    try {
      final result = _repository
          .addNewAccount(Account(login: event.login, password: event.password));
      _updateScreen(false, '${event.login} добавлен');
    } catch (e) {
      _updateScreen(false, 'error');
    }
  }

  Future<void> _logoutRequest() async {
    ids.clear();
    _updateScreen(false, 'Выход');
    print('Выход');
  }

  Future<void> _sellSkinRequest() async {
    final session = Network.instance;
    var res = await session.checkEquus();
    var document = parse(res);
    final htmlEquus = document.querySelector("#reserve")!.innerHtml;
    final equus = int.parse(htmlEquus.replaceAll(' ', ''));

    if ((equus < 37500) && (equus != null)) {
      await session.sellSkin();
      _updateScreen(false, 'Продаю кожу');
      print('Продать кожу');
    }
  }

  Future<bool> _loginRequest(login, password) async {
    Network.dio.interceptors.clear();
    final session = Network.instance;
    var res = await session.login(login, password);
    _updateScreen(false, 'Попытка входа в $login');

    return res;
  }

  //collect all cows from meadows
  Future<void> _collectSkinRequest() async {
    try {
      final session = Network.instance;
      final data = await session.getMeadows();
      _parseData(data);

      for (var i = 0; i < ids.length; i++) {
        await Future.delayed(const Duration(milliseconds: 500), () {
          session.collectSkin(ids[i]);
          _updateScreen(false, 'Собираю ${i + 1}');
        });
      }
    } catch (e) {
      _updateScreen(false, 'error');
    }
  }

  //set new cows to meadows
  Future<void> _setSkinRequest() async {
    try {
      final session = Network.instance;
      for (var i = 0; i < ids.length; i++) {
        await Future.delayed(const Duration(milliseconds: 500), () {
          session.setSkin(ids[i]);
          _updateScreen(false, 'Коровы ${i + 1}');
        });
      }
    } catch (e) {
      _updateScreen(false, 'error');
    }
  }

  //get meadows id
  Future<void> _parseData(data) async {
    final document = parse(data);
    final lug = document.querySelectorAll("#id\\[\\]").length; //всего лугов

    for (var i = 0; i < lug; i++) {
      var id = document.querySelectorAll("#id\\[\\]")[i].attributes.values.last;
      ids.add(id);
    }
  }
}
