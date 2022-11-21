import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lw/main/bloc/main_bloc.dart';
import 'package:lw/main/bloc/main_state.dart';
import 'package:lw/styles/colors.dart';
import 'package:lw/styles/text_styles.dart';

import 'bloc/main_event.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case InitialState:
                return Container();
              case UpdateScreen:
                var text = (state as UpdateScreen).text;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                      child: Container(
                        width: 150,
                        color: const Color.fromRGBO(34, 34, 34, 100),
                        child: Column(
                          children: const [
                            Text('Account 1', style: CustomStyles.defaultText),
                            Text('Account 2', style: CustomStyles.defaultText),
                            Text('Account 3', style: CustomStyles.defaultText),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: const Color.fromRGBO(41, 41, 41, 100),
                      child: Text('c'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0, top: 0, bottom: 0),
                      child: Container(
                        width: 300,
                        color: const Color.fromRGBO(34, 34, 34, 100),
                        child: Text(''),
                      ),
                    )
                  ],
                );
            }
            return Placeholder();
      });
  }
}
