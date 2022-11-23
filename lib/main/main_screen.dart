import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lw/main/bloc/main_bloc.dart';
import 'package:lw/main/bloc/main_state.dart';
import 'package:lw/styles/colors.dart';
import 'package:lw/styles/text_styles.dart';
import 'package:lw/widgets/login_tf.dart';

import 'bloc/main_event.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(41, 41, 41, 100),
      appBar: AppBar(
        backgroundColor: Colors.black26,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26,
            ),
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.black12,
                      title: Text('Добавить аккаунт'),
                      actions: [
                        TextFieldWidget(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {},
                          validator: (value) {},
                          controller: _loginController,
                        ),
                        TextFieldWidget(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {},
                          validator: (value) {},
                          controller: _passwordController,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              context.read<MainBloc>().add(AddNewAccount(_loginController.text, _passwordController.text));
                              Navigator.of(context).pop();
                              },
                            child: Text('Log in')
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.of(context).pop(); },
                            child: Text('Close')
                        ),
                      ],
                    );
                  }
              );
            },
            child:
                const Text('Добавить аккаунт', style: CustomStyles.appBarText),
          ),
          const SizedBox(width: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26,
            ),
            onPressed: () {
              context.read<MainBloc>().add(Lug());
            },
            child: const Text('Собрать луга', style: CustomStyles.appBarText),
          ),
          const SizedBox(width: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26,
            ),
            onPressed: () {
              context.read<MainBloc>().add(Lug2());
            },
            child: const Text('Собрать мастерские',
                style: CustomStyles.appBarText),
          )
        ],
      ),
      body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
        switch (state.runtimeType) {
          case InitialState:
            return Container();
          case UpdateScreen:
            var accounts = (state as UpdateScreen).accounts;
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  color: Colors.blueGrey,
                  child: Column(
                    children: List.generate(accounts.length, (index) {
                      final account = accounts[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Text(account.login),
                      );
                    })
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Text('4444444444444444444444444'),
                      ],
                    ),
                  ),
                ),
                Container(
                    width: 200,
                    color: Colors.blueGrey,
                    child: Column(
                      children: [
                        Text(''),
                      ],
                    ))
              ],
            );
        }
        return Placeholder();
      }),
    );
  }
}
