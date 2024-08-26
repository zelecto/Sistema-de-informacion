import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldFrom extends StatelessWidget {
  const TextFieldFrom({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.maxLength,
    this.minLength,
    this.type,
    this.inputFormatters = const [],
    this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int? maxLength;
  final int? minLength;
  final TextInputType? type;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            labelText: labelText,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            counterText: ''),
      ),
    );
  }
}
