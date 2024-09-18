import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:creeasy/card_manage/change_card/change_card.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/rectangle_icon_text_comp.dart';
import 'package:auto_size_text/auto_size_text.dart';


class PayHistoryTileComp extends StatefulWidget {
  final String payPlace;            // 利用場所
  final DateTime payDate;           // 利用日
  final String payCardName;         // 利用カード名
  final String connectBank;         // カード資金口座
  final int payPrice;               // 利用額
  final bool isSetureMoney;         // 資金確保済みか

  const PayHistoryTileComp({super.key,
    required this.payPlace,
    required this.payDate,
    required this.payCardName,
    required this.connectBank,
    required this.payPrice,
    required this.isSetureMoney
  });


  @override
  _PayHistoryTileCompState createState() => _PayHistoryTileCompState();
}

class _PayHistoryTileCompState extends State<PayHistoryTileComp> {
  // ------- デバッグ用 -------
  final bool _debugBackColor = false;
  // ------------------------
  late String _finalPayDate;
  late bool _isThisYear;

  @override
  void initState() {
    super.initState();
    final _keepPayDate = DateFormat('yyyy年MM月dd日(E)', 'ja_JP').format(widget.payDate);
    late String _year;
    late String _month;
    late String _day;

    if (_keepPayDate.substring(0, 4) == DateTime.now().toString().substring(0, 4)) {
      _year = '';
      _isThisYear = true;
    } else {
      _year = '${_keepPayDate.substring(0, 4)}年';
      _isThisYear = false;
    }
    if (_keepPayDate.substring(5, 6) == '0') {
      _month = _keepPayDate.substring(6, 7);
    } else {
      _month = _keepPayDate.substring(5, 7);
    }
    if (_keepPayDate.substring(8, 9) == '0') {
      _day = _keepPayDate.substring(9, 10);
    } else {
      _day = _keepPayDate.substring(8, 10);
    }

    _finalPayDate = '$_year$_month月$_day日${_keepPayDate.substring(11)}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: OutlinedButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ChangeCardPage(selectedCardName: widget.card_name),
          //     fullscreenDialog: true,
          //   ),
          // );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xffeeeeee),
          side: const BorderSide(color: Colors.black, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          fixedSize: const Size.fromHeight(155)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 20,
              child: Container(
                color: (_debugBackColor) ?Colors.blue[100] :null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Text(
                        widget.payCardName,
                        style: TextStyle(color: Colors.black, fontSize: (widget.payCardName.length<=8) ?23 :20),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    (!widget.isSetureMoney)
                      ? Flexible(
                        flex: 3,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(10, 11, 10, 11),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            '💰確保済にする',
                            style: TextStyle(fontSize: 16, color: Colors.black,),
                          )
                        ),
                      )
                      : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
            const Flexible(flex: 1, child: SizedBox(height: double.infinity,)),
            Flexible( // q
              flex: 32,
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        rectangleIconTextComp(argIcon: Icons.today_outlined, argText: _finalPayDate, isMinMainAxisSize: true, customBackColor: const Color(0xffeeeeee), customBetween: 6, customIconSize: 17, customTextSize: 15, customMaxLines: 1),
                        rectangleIconTextComp(argIcon: Icons.credit_card, argText: widget.payCardName, isMinMainAxisSize: true, customBackColor: const Color(0xffeeeeee), customBetween: 6, customIconSize: 17, customTextSize: 15, customMaxLines: 1),
                        rectangleIconTextComp(argIcon: Icons.account_balance_outlined, argText: widget.connectBank, isMinMainAxisSize: true, customBackColor: const Color(0xffeeeeee), customBetween: 6, customIconSize: 17, customTextSize: 15, customMaxLines: 1),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      formatYen(widget.payPrice),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize:
                          (widget.payPrice.toString().length<6)
                            ?27
                            : (widget.payPrice.toString().length==6)
                              ?23
                              :(widget.payPrice.toString().length==7)
                                ?23
                                :20
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                    )
                  )
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
