import 'package:flutter/material.dart';
// import文：import 'package:creeasy/COMMON_COMPS/display_parts/no_save_close_comp.dart';


Padding noSaveCloseComp({int? messageType = 0}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Text(
      (messageType == 0) ? '保存せずに閉じるには右上の×ボタンを押してください' : '保存せずに閉じるには\n右上の×ボタン or 左上の<ボタン を押してください',
      style: const TextStyle(
        fontSize: 11.5,
        color: Colors.black38,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    ),
  );
}