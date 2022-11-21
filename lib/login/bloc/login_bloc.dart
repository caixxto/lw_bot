import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:lw/login/bloc/login_event.dart';
import 'package:lw/login/bloc/login_state.dart';
import 'package:lw/network.dart';
import 'package:lw/session.dart';
import 'package:requests/requests.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState()) {
    _initState();
    on<LoginButtonPressed>((event, state) async {
      _sendRequest(event.login, event.password);
    });

    on<DataChanged>((event, state) async {
      emit(UpdateScreen());
    });
  }

  Future<void> _initState() async {
    //_sendRequest();
  }

  void _sendRequest(String login, String password) async {

    //final session = Session();
    //session.req("https://www.lowadi.com", "https://www.lowadi.com/site/doLogIn", login, password);
    final session = Network.instance;
    session.login(login, password);

  }

}