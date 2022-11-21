import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextInputType keyboardType;
  bool obscureText;
  TextInputAction? textInputAction;
  ValueChanged<String>? onChanged;
  FormFieldValidator<String>? validator;
  TextEditingController? controller;

  TextFieldWidget({
    required this.keyboardType,
    this.obscureText = false,
    required this.textInputAction,
    required this.onChanged,
    required this.validator,
    this.controller = null,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        fillColor: Colors.white12,
      ),
    );
  }
}
