import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:lw/accounts/acc_manager.dart';
import 'package:lw/main/bloc/main_event.dart';
import 'package:lw/main/bloc/main_state.dart';
import 'package:lw/network.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AccountRepository _repository = AccountRepository.instance;
  final List<String> ids = [];

  MainBloc() : super(InitialState()) {
    _initState();

    on<DataChanged>((event, state) async {
      // _sendRequest();
    });

    on<AddNewAccount>(_addNewAccount);

    on<Lug>((event, state) async {
      for (var i = 0; i < _repository.getAccounts.length; i++) {
        final account = _repository.getAccounts;
        await _loginRequest(account[i].login, account[i].password);
        await _collectSkinRequest();
        await _setSkinRequest();
        await logoutRequest();
      }
    });
  }

  Future<void> _initState() async {
    _updateScreen();
  }

  void _updateScreen() async {
    emit(UpdateScreen(await _repository.getAccounts));
  }

  void _addNewAccount(AddNewAccount event, Emitter<MainState> state) async {
    try {
      final result = _repository
          .addNewAccount(Account(login: event.login, password: event.password));
      _updateScreen();
    } catch (e) {
      emit(InitialState());
    }
  }

  Future<void> logoutRequest() async {
    ids.clear();
    Network.dio.interceptors.clear();
    print('Log Out');
  }

  Future<void> _loginRequest(login, password) async {
    final session = Network.instance;
    //Future.delayed(const Duration(milliseconds: 1500));
     await session.login(login, password);
  }

  //collect all cows from meadows
  Future<void> _collectSkinRequest() async {
    final session = Network.instance;

    final data = await session.getMeadows();
    //session.collectSkin(_parseData(data));
    _parseData(data);

    for (var i = 0; i < ids.length; i++) {
      await Future.delayed(Duration(seconds: 1), () {
        session.collectSkin(ids[i]);
        print('collect skin $i');
      });
    }
  }

  //set new cows to meadows

  Future<void> _setSkinRequest() async {
    final session = Network.instance;
    for (var i = 0; i < ids.length; i++) {
      await Future.delayed(Duration(seconds: 1), () {
          session.setSkin(ids[i]);
          print('set skin $i');

      });
    }
  }

  //get meadows id
  Future<void> _parseData(data) async {
    final document = parse(data);
    final lug = document.querySelectorAll("#id\\[\\]").length; //всего лугов

    for (var i = 0; i < lug; i++) {
      var id = document.querySelectorAll("#id\\[\\]")[i].attributes.values.last;
      ids.add(id);
      print('ids done $id');
    }
    //return ids;
  }
}
