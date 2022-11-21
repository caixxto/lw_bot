import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw/main/bloc/main_event.dart';
import 'package:lw/main/bloc/main_state.dart';
import 'package:lw/network.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(InitialState()) {
    _initState();

    on<DataChanged>((event, state) async {
      _sendRequest();
    });
  }

  Future<void> _initState() async {
    emit(UpdateScreen());
  }

  void _sendRequest() async {
    // var r1 = await Requests.post('https://www.lowadi.com/marche/achat', body: {
    //   'id': '111',
    //   'mode': 'centre',
    //   'nombre': '1',
    //   'typeRedirection': 'box'
    // });
    // //r1.raiseForStatus();
    // print(r1.body);
    // print(r1.headers);

    var session = Network.instance;
    session.buyBox();



    emit(UpdateScreen());
  }

}