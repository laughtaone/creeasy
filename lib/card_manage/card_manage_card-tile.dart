import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:creeasy/card_manage/change_card/change_card.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/rectangle_icon_text_comp.dart';
import 'package:auto_size_text/auto_size_text.dart';


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
      padding: const EdgeInsets.only(bottom: 15),
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
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,        // これが効かない
                children: [
                  Expanded(
                    child: Text(
                      widget.card_name,
                      style: TextStyle(color: Colors.black, fontSize: (widget.card_name.length<=8) ?22 :19),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  (widget.bool_pointup)
                    ? rectangleIconTextComp(argIcon: Icons.auto_awesome_outlined, argText: 'Pアップ有', customElementColor: const Color(0xff555555))
                    : const SizedBox.shrink()
                ],
              ),
            ),
            Expanded( // q
              flex: 7,
              child: Row( // r
                children: [
                  Expanded( // s1
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AutoSizeText(
                          '基本還元率',
                          style: TextStyle(color: Colors.black),
                        ),
                        Column(
                          children: [
                            AutoSizeText(
                              '${widget.return_rate_unit}円につき',
                              style: const TextStyle(
                                fontSize: 8,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              minFontSize: 8,
                            ),
                            AutoSizeText(
                              '${formatReturnRate(widget.return_rate)}%',
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 3),
                  const SizedBox(height: 60, child: VerticalDivider()),
                  const SizedBox(width: 3),
                  Expanded( // s2
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AutoSizeText(
                          '引落額集計期間',
                          style: TextStyle(color: Colors.black),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 6),
                        AutoSizeText(
                          widget.target_range,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 17
                          ),
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 3),
                  const SizedBox(height: 60, child: VerticalDivider()),
                  const SizedBox(width: 3),
                  Expanded( // s3
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AutoSizeText(
                          '引き落とし日',
                          style: TextStyle(color: Colors.black),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 6),
                        AutoSizeText(
                          widget.pay_date,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 17
                          ),
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
