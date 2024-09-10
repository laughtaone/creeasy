import 'package:flutter/material.dart';
// 「現在の還元率：？%」の長方形

Container nowReturnRate(double recvReturnRate) {
  String stringRecvReturnRate;

  // recvReturnRateが整数かどうかを判断
  // これにより例えば1.0%の場合「1%」と表示できる
  if (recvReturnRate == recvReturnRate.toInt().toDouble()) {
    // 整数の場合
    stringRecvReturnRate = recvReturnRate.toInt().toString();
  } else {
    // 小数の場合
    stringRecvReturnRate = recvReturnRate.toString();
  }

  return Container(
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: const Color(0xfffafafa),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('現在の還元率：',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        Text('$stringRecvReturnRate%',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22))
      ],
    ),
  );
}
