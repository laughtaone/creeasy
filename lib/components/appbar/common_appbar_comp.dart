import 'package:flutter/material.dart';
// import文：import 'package:creeasy/COMMON_COMPS/appbar/common_appbar_comp.dart';




AppBar commonAppBarComp({
  required BuildContext context,
  required IconData recvIcon,
  required String recvText
}) {
  return AppBar(
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(recvIcon, color: Colors.black),
        const SizedBox(width: 5),
        Text(recvText),
      ],
    ),
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
  );
}