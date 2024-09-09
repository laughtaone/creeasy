import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/card_manage.dart';
import 'package:intl/intl.dart';
import 'package:creeasy/card_manage/change_bank/change_bank.dart';


class CardManageBankTile extends StatelessWidget {
  final String recvBankName; // 銀行名
  final int recvBankType;    // 銀行のタイプ(0:通常・1:貯蓄ボックス)

  CardManageBankTile({
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
          backgroundColor: Color(0xffeeeeee),
          side: BorderSide(color: Colors.black, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          fixedSize: Size.fromHeight(80)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    recvBankName,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 11),
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Icon(
                        (recvBankType==0) ? Icons.account_balance_outlined : Icons.savings_outlined,
                        size: 20,
                        color: (recvBankType==0 || recvBankType==1) ? Colors.black : Colors.white
                      ),
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
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
