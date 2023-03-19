import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lw/global_vars.dart';
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
  final TextEditingController _pauseController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black12,
            ),
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.black12,
                      title: const Text('Добавить аккаунт'),
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
                            child: const Text('Log in')
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.of(context).pop(); },
                            child: const Text('Close')
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
              backgroundColor: Colors.black12,
            ),
            onPressed: () {
              context.read<MainBloc>().add(Lug());
            },
            child: const Text('Собрать луга', style: CustomStyles.appBarText),
          ),
          const SizedBox(width: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black12,
            ),
            onPressed: () {
              context.read<MainBloc>().add(Lug2());
            },
            child: const Text('Собрать мастерские',
                style: CustomStyles.appBarText),
          ),
          const SizedBox(width: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black12,
            ),
            onPressed: () {
              context.read<MainBloc>().add(BuyHorses(int.parse(_pauseController.text)));
            },
            child: const Text('Выкупить табун',
                style: CustomStyles.appBarText),
          ),
          SizedBox(
            width: 100,
            child: TextField(
              controller: _pauseController,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black12,
            ),
            onPressed: () {
              context.read<MainBloc>().add(ParseData());
            },
            child: const Text('Спарсить данные',
                style: CustomStyles.appBarText),
          )
        ],
      ),
      body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
        switch (state.runtimeType) {
          case InitialState:
            return const CircularProgressIndicator();
          case UpdateData:
            var accounts = (state as UpdateData).accounts;
            var data = state.accountData;
            var check = state.check;
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: 150,
                  color: const Color.fromRGBO(34, 34, 34, 100),
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(accounts.length, (index) {
                          final account = accounts[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<MainBloc>().add(ChangeAccount(index));
                            },
                            child: Text(
                                account.login,
                                style: check ? CustomStyles.defaultText : CustomStyles.appBarText
                            ),
                          );
                        })
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromRGBO(41, 41, 41, 100),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'Экю: ${data.equus}',
                              style: CustomStyles.defaultText,
                            ),
                            Text(
                              'Пропы: ${data.passes}',
                              style: CustomStyles.defaultText,
                            ),
                            Column(
                              children: List.generate(data.market.length, (index) {
                                return Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Image.network('${data.market[index].image}'),
                                    const SizedBox(width: 10),
                                    //Text('${data.market[index].name}', style: CustomStyles.defaultText),
                                    Text('${data.market[index].count}', style: CustomStyles.defaultText)
                                  ],
                                );
                              })
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    width: 200,
                    color: const Color.fromRGBO(34, 34, 34, 100),
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              context.read<MainBloc>().add(SaveDataExcel());
                            },
                            child: const Text('Save')),
                      ],
                    ))
              ],
            );
          case UpdateScreen:
            var accounts = (state as UpdateScreen).accounts;
            var check = state.check;
            var status = state.status;
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: 150,
                  color: const Color.fromRGBO(34, 34, 34, 100),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(accounts.length, (index) {
                        final account = accounts[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<MainBloc>().add(ChangeAccount(index));
                          },
                          child: Text(
                              account.login,
                              style: check ? CustomStyles.defaultText : CustomStyles.appBarText
                          ),
                        );
                      })
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromRGBO(41, 41, 41, 100),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                              'Статус: $status',
                            style: CustomStyles.defaultText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    width: 200,
                    color: const Color.fromRGBO(34, 34, 34, 100),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<MainBloc>().add(OpenList());
                          },
                          child: const Text('Open txt file'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MainBloc>().add(DeleteAccount());
                          },
                          child: const Text('Delete account'),
                        ),
                      ],
                    ))
              ],
            );
        }
        return const Placeholder();
      }),
    );
  }
}
