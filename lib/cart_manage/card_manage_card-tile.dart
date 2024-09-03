import 'package:flutter/material.dart';
import 'package:creeasy/cart_manage/card_manage.dart';
import 'package:intl/intl.dart';

class CardManageCardTile extends StatelessWidget {
  const CardManageCardTile({
    required this.card_name,
    required this.return_rate,
    required this.target_range,
    required this.pay_date,
  });

  final String card_name;       // カード名
  final double return_rate;     // 還元率
  final String target_range;    // 支払対象期間
  final String pay_date;        // 引き落とし日

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xffeeeeee),
          side: BorderSide(color: Colors.black, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          fixedSize: Size.fromHeight(130)),
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
                    card_name,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.auto_awesome_outlined,
                          size: 15,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 2),
                        Text(
                          'ポイントアップあり',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text('還元率', style: TextStyle(color: Colors.black),),
                        Text('$return_rate%', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),)
                      ],
                    ),
                    SizedBox(width: 5),
                    Container(height: 60, child: VerticalDivider()),
                    SizedBox(width: 5),
                    Column(
                      children: [
                        Text('支払対象期間', style: TextStyle(color: Colors.black),),
                        Text('$target_range', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),)
                      ],
                    ),
                    SizedBox(width: 5),
                    Container(height: 60, child: VerticalDivider()),
                    SizedBox(width: 5),
                    Column(
                      children: [
                        Text('引き落とし日', style: TextStyle(color: Colors.black),),
                        Text('$pay_date', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),)
                      ],
                    ),
                  ],
                ),
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
