import 'package:flutter/material.dart';
import 'package:creeasy/components/display_parts/circle_icon_comp.dart';

Align bankExampleIcon() {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.black, // 色
        //   width: 1, // 太さ
        // ),
        color: const Color(0xffeeeeee),
        borderRadius: BorderRadius.circular(7)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          circleIconComp(customCircleSize: 24, customIconSize: 18, argIcon: Icons.account_balance_outlined),
          const SizedBox(width: 3),
          const Text('通常口座', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 9),
          circleIconComp(customCircleSize: 24, customIconSize: 18, argIcon: Icons.savings_outlined),
          const SizedBox(width: 3),
          const Text('口座内のボックス', style: TextStyle(fontSize: 14)),
        ],
      ),
    ),
  );
}