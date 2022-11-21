import 'package:flutter/material.dart';
import 'package:lw/login/bloc/login_bloc.dart';
import 'package:lw/login/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw/main/main_screen.dart';
import 'package:lw/styles/text_styles.dart';

import 'main/bloc/main_bloc.dart';


void main() async {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginBloc(),
        ),
        BlocProvider(
          create: (_) => MainBloc(),
        ),
      ],
      child: const MyApp(),

    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(41, 41, 41, 100),
        appBar: AppBar(
        backgroundColor: Colors.black26,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26,
            ),
            onPressed: () {},
            child: const Text('Добавить аккаунт', style: CustomStyles.appBarText),
          ),
          const SizedBox(width: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26,
            ),
            onPressed: () {},
            child: const Text('Собрать луга', style: CustomStyles.appBarText),
          ),
          const SizedBox(width: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26,
            ),
            onPressed: () {},
            child: const Text('Собрать мастерские', style: CustomStyles.appBarText),
          )
        ],
      ),
          body: const MainScreen()
      ),
    );
  }
}

