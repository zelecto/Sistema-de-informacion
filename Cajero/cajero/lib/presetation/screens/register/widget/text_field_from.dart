import 'package:flutter/material.dart';

class TextFieldFrom extends StatelessWidget {
  const TextFieldFrom({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.maxLength,
    this.type,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int? maxLength;
  final TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextField(
        keyboardType: type,
        controller: controller,
        maxLength: maxLength,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
