import 'package:flutter_html/flutter_html.dart';

abstract class MainState {}

class InitialState extends MainState {}

class UpdateScreen extends MainState {
  final String text;
  UpdateScreen(this.text);

}