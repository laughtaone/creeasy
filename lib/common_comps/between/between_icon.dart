import 'package:flutter/material.dart';
// 何かと何かの間のアイコン


Padding betweenIcon({
  required IconData recvIcon,
  List<double> customTBPadding = const [20, 20]
}) {
  return Padding(
    padding: EdgeInsets.only(top: customTBPadding[0], bottom: customTBPadding[1]),
    child: Icon(recvIcon, size: 27)
  );
}
