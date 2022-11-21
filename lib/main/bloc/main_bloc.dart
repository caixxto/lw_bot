import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
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
    emit(UpdateScreen(''));
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
    //session.buyBox();
    final data = await session.getData();
    //print(data);
    parseData(data);



    //emit(UpdateScreen(''));
  }

  void parseData(data) async {

    var document = parse(data);
    var passes = document.querySelector("#pass");
    var equus = document.querySelector("#reserve");
    //var inv = document.querySelector("#page-contents > section > div > div > div.grid-cell.width-30.align-top.spacer-large-left > div.module.module-style-6 > div");
    print(passes!.innerHtml);
    print(equus!.innerHtml);
    //emit(UpdateScreen(elem.innerHtml));
  }

}