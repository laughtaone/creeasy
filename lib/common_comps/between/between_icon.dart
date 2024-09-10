import 'package:flutter/material.dart';
// 何かと何かの間のアイコン


Padding betweenIcon(IconData recvIcon) {
  return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Icon(recvIcon, size: 27));
}
