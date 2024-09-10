import 'package:flutter/material.dart';
// 右上の×ボタン


class ToprightCloseButton extends StatelessWidget {
  const ToprightCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(right: 20),
      icon: const Icon(Icons.close, size: 27),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}