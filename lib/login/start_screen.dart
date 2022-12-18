import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw/login/bloc/login_bloc.dart';
import 'package:lw/login/bloc/login_event.dart';
import 'package:lw/login/bloc/login_state.dart';
import 'package:lw/main/main_screen.dart';
import 'package:lw/styles/text_styles.dart';
import 'package:lw/widgets/login_tf.dart';


class StartScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  StartScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Text('Загрузить список аккаунтов')
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text('Собрать мастерские')
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text('Выкупить табун')
                ),
              ],
            ),

          );
        }
      ),
    );
  }
}
