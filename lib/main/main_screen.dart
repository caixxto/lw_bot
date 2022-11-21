import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lw/main/bloc/main_bloc.dart';
import 'package:lw/main/bloc/main_state.dart';

import 'bloc/main_event.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case InitialState:
                return Container();
              case UpdateScreen:
                return Container(
                  color: Colors.white12,
                  child: Column(
                    children: [
                      Text(''),
                      Text(''),
                      ElevatedButton(
                        onPressed: () {
                          context.read<MainBloc>().add(DataChanged());
                        },
                        child: Text('click'),
                      ),
                    ],
                  ),
                );
            }
            return Placeholder();
      }),
    );
  }
}
