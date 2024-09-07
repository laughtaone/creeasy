import 'package:flutter/material.dart';
// 入力フィールド(選択/直表示形式)単体


class compInputDirectSelectType extends StatefulWidget {
  final List elementsList;
  final int? resvNowSelectingIndex;
  final double customFontSize;
  final Function(int) argCallback; // コールバック関数

  compInputDirectSelectType({
    required this.elementsList,             // 選択する要素を格納したリスト（※必須）
    this.resvNowSelectingIndex,             // 現在選択中の要素のインデックス番号(デフォでは未選択を示すnull)
    this.customFontSize = 15,               // 選択要素の文字の大きさをカスタム(デフォは15)
    required this.argCallback,              // コールバック関数（※必須）
  });

  @override
  _compInputDirectSelectTypeState createState() => _compInputDirectSelectTypeState();
}

class _compInputDirectSelectTypeState extends State<compInputDirectSelectType> {
  // -------------------------------- 変数処理 --------------------------------
  int? _newSelectIndex; // 選択中の要素のインデックス

  @override
  void initState() {
    super.initState();
    _newSelectIndex = widget.resvNowSelectingIndex;
  }
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.elementsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(130, 5),
                backgroundColor: (_newSelectIndex == index)
                    ? Color(0xffdedede)
                    : Color(0xfffefefe),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ).copyWith(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                setState(() {
                  _newSelectIndex = index;
                });
                widget.argCallback(index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: (_newSelectIndex == index) ? Colors.black : Colors.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    widget.elementsList[index],
                    style: TextStyle(
                      fontSize: widget.customFontSize,
                      color: Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}