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
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  StartScreen({Key? key}) : super(key: key);

  static const url = 'https://www.lowadi.com/site/doLogIn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Login', style: CustomStyles.defaultText),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        context.read<LoginBloc>().add(DataChanged());
                      },
                      validator: (value) {
                      },
                      controller: _loginController,
                    ),
                    const SizedBox(height: 30),
                    const Text('Password', style: CustomStyles.defaultText),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        context.read<LoginBloc>().add(DataChanged());
                      },
                      validator: (value) {},
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () {
                            context.read<LoginBloc>().add(LoginButtonPressed(_loginController.text, _passwordController.text));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>  MainScreen(),
                            ));
                        },
                        child: const Text('Log In', style: CustomStyles.defaultText))
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
