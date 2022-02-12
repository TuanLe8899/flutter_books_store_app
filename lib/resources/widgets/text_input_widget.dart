import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final FocusNode focusNode;
  final String hintText;
  final controller;
  const TextInputWidget({Key? key, required this.focusNode, required this.hintText, required this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        focusNode: focusNode,
        decoration: InputDecoration(
          border: null,
          hintText: hintText,
        ),
        controller: controller,
      ),
    );
  }
}
