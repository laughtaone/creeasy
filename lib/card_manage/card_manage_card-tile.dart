import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/card_manage.dart';
import 'package:intl/intl.dart';

class CardManageCardTile extends StatelessWidget {
  const CardManageCardTile({
    required this.card_name,
    required this.return_rate_unit,
    required this.return_rate,
    required this.target_range,
    required this.pay_date,
    required this.bool_pointup,
  });

  final String card_name; // カード名
  final int return_rate_unit; // 還元率計算単位(x円につきのx)
  final double return_rate; // 還元率
  final String target_range; // 支払対象期間
  final String pay_date; // 引き落とし日
  final bool bool_pointup; // ポイントアップあり/なし

  // final String formatted_return_rate = formatReturnRate(return_rate);

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
                  (bool_pointup)
                      ? Container(
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
                      : SizedBox.shrink()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '基本還元率',
                          style: TextStyle(color: Colors.black),
                        ),
                        Column(
                          children: [
                            Text('$return_rate_unit円につき',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.black,
                                )),
                            Text('${formatReturnRate(return_rate)}%',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                )),
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: 5),
                    Container(height: 60, child: VerticalDivider()),
                    SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '支払対象期間',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '$target_range',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 17),
                        )
                      ],
                    ),
                    SizedBox(width: 5),
                    Container(height: 60, child: VerticalDivider()),
                    SizedBox(width: 5),
                    Column(
                      children: [
                        Text(
                          '引き落とし日',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '$pay_date',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 17),
                        )
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

// 小数部分の処理
String formatReturnRate(double rate) {
  // 小数点以下が0の場合は整数部分のみを表示
  if (rate % 1 == 0) {
    return rate.toStringAsFixed(0);
  } else {
    return rate.toStringAsFixed(1);
  }
}
