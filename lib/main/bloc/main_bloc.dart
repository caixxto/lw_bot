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
      await Future.delayed(Duration(milliseconds: 1000));
      _loginRequest(_repository.getAccounts.first.login, _repository.getAccounts.first.password);
      await Future.delayed(Duration(milliseconds: 1500));
      _collectSkinRequest();


    });

    on<Lug2>((event, state) async {
      _collectSkinRequest();
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
      final result = _repository.addNewAccount(Account(login: event.login, password: event.password));
      _updateScreen();
    } catch (e) {
      emit(InitialState());
    }
  }


  void _loginRequest(login, password) async {
    // var r1 = await Requests.post('https://www.lowadi.com/marche/achat', body: {
    //   'id': '111',
    //   'mode': 'centre',
    //   'nombre': '1',
    //   'typeRedirection': 'box'
    // });
    // //r1.raiseForStatus();
    // print(r1.body);
    // print(r1.headers);

    // var session = Network.instance;
    // //session.buyBox();
    // final data = await session.getData();
    // //print(data);
    // parseData(data);

    var session = Network.instance;
    final acc = _repository.getAccounts;

    session.login(login, password);

    //emit(UpdateScreen(''));
  }

  //collect all cows from meadows
  void _collectSkinRequest() async {
    var session = Network.instance;
    final data = await session.getMeadows();
    session.collectSkin(_parseData(data));

    for(var i = 0; i < ids.length; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
     session.collectSkin(ids[i]);
    }

  }

  //get meadows id
  List<String> _parseData(data) {
    var document = parse(data);
    var lug = document.querySelectorAll("#id\\[\\]").length; //всего лугов

    for(var i = 0; i < lug; i++) {
      var id = document.querySelectorAll("#id\\[\\]")[i].attributes.values.last;
      ids.add(id);
    }
    return ids;
  }

}