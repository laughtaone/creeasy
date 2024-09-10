import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:creeasy/card_manage/change_card/change_card.dart';


class CardManageCardTile extends StatefulWidget {
  final String card_name; // カード名
  final int return_rate_unit; // 還元率計算単位(x円につきx)
  final double return_rate; // 還元率
  final String target_range; // 引落額集計期間
  final String pay_date; // 引き落とし日
  final bool bool_pointup; // ポイントアップあり/なし
  // final Function cardTileOnpressed;     // カードタイルが押された時の処理

  const CardManageCardTile({super.key, 
    required this.card_name,
    required this.return_rate_unit,
    required this.return_rate,
    required this.target_range,
    required this.pay_date,
    required this.bool_pointup,
    // required this.cardTileOnpressed
  });

  @override
  _CardManageCardTileState createState() => _CardManageCardTileState();
}

class _CardManageCardTileState extends State<CardManageCardTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeCardPage(selectedCardName: widget.card_name),
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
          fixedSize: const Size.fromHeight(130)
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.card_name,
                        style: const TextStyle(color: Colors.black, fontSize: 22),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    (widget.bool_pointup)
                      ? Container(
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.auto_awesome_outlined,
                                size: 15,
                                color: Colors.black54,
                              ),
                              SizedBox(width: 2),
                              Text(
                                'P UPあり',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox.shrink()
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '基本還元率',
                              style: TextStyle(color: Colors.black),
                            ),
                            Column(
                              children: [
                                Text('${widget.return_rate_unit}円につき',
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                  )),
                                Text('${formatReturnRate(widget.return_rate)}%',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 3),
                      const SizedBox(height: 60, child: VerticalDivider()),
                      const SizedBox(width: 3),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '引落額集計期間',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.target_range,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 17
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 3),
                      const SizedBox(height: 60, child: VerticalDivider()),
                      const SizedBox(width: 3),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '引き落とし日',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.pay_date,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 17
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
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
