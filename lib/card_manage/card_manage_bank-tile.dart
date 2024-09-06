import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/card_manage.dart';
import 'package:intl/intl.dart';
import 'package:creeasy/card_manage/change_bank/change_bank.dart';


class CardManageBankTile extends StatelessWidget {
  const CardManageBankTile({
    required this.bank_name,
  });

  final String bank_name; // 銀行名

  // final String formatted_return_rate = formatReturnRate(return_rate);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeBankPage(),
              fullscreenDialog: true,
            ),
          );
        },
        style: OutlinedButton.styleFrom(
            backgroundColor: Color(0xffeeeeee),
            side: BorderSide(color: Colors.black, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            fixedSize: Size.fromHeight(80)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bank_name,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// intを受け取り¥と,をつけて返す
String formatYen(int amount) {
  final formatter = NumberFormat('#,###', 'ja_JP');
  return '¥${formatter.format(amount)}';
}

// 小数部分の処理
String formatReturnRate(double rate) {
  // 小数点以下が0の場合は整数部分のみを表示
  if (rate % 1 == 0) {
    return rate.toStringAsFixed(0);
  } else {
    return rate.toStringAsFixed(1);
  }
}
