import 'package:app_ban_sach/resources/strings.dart';
import 'package:flutter/material.dart';

class HorizontalBar extends StatelessWidget {
  final String nameTitle;
  const HorizontalBar({Key? key, required this.nameTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(nameTitle, style: const TextStyle(fontSize: fontSizeCustom, color: Colors.white)),
      color: Colors.green,
      width: MediaQuery.of(context).size.width,
    );
  }
}
