import 'package:flutter/material.dart';

Align bankExampleIcon() {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.black, // 色
        //   width: 1, // 太さ
        // ),
        color: Color(0xffeeeeee),
        borderRadius: BorderRadius.circular(7)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24, height: 24,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Icon(Icons.account_balance_outlined, size: 18)
          ),
          SizedBox(width: 3),
          Text('通常口座', style: TextStyle(fontSize: 14)),
          SizedBox(width: 9),
          Container(
            width: 24, height: 24,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Icon(Icons.savings_outlined, size: 17)
          ),
          SizedBox(width: 3),
          Text('口座内のボックス', style: TextStyle(fontSize: 14)),
        ],
      ),
    ),
  );
}