import 'package:flutter/material.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String nameBtn;
  final onPressed;
  const ElevatedButtonCustom({Key? key, required this.nameBtn, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(nameBtn, style: const TextStyle(fontSize: 16, color: Colors.black),),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.grey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            )
          )
        ),
      ),
    );
  }
}
