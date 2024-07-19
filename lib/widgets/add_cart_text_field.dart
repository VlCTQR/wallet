import 'package:flutter/material.dart';

class TextFieldAddCart extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final TextInputType? textInputType;
  final VoidCallback? onChanged;

  const TextFieldAddCart(
      {Key? key,
      required this.textEditingController,
      required this.labelText,
      required this.hintText,
      this.onChanged,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: (value) {
        onChanged?.call();
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
