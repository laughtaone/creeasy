import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:creeasy/5tabs/card_manage/change_bank/change_bank.dart';
import 'package:creeasy/components/display_parts/circle_icon_comp.dart';


class CardManageBankTile extends StatelessWidget {
  final String recvBankName; // 銀行名
  final int recvBankType;    // 銀行のタイプ(0:通常・1:貯蓄ボックス)

  const CardManageBankTile({super.key, 
    required this.recvBankName,
    this.recvBankType = 0
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeBankPage(
                selectedBankName: recvBankName,
              ),
              fullscreenDialog: true,
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xffeeeeee),
          side: const BorderSide(color: Colors.black, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          fixedSize: const Size.fromHeight(80)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    recvBankName,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 11),
                    child: circleIconComp(
                      argIcon: (recvBankType==0) ? Icons.account_balance_outlined : Icons.savings_outlined,
                      customCircleSize: 47
                    ),
                  ),
                ],
              ),
            )
          ],
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
