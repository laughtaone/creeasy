import 'package:flutter/material.dart';


// 縦に並んだ選択肢から選ばせるコンポーネント
class SingleOptionTextButtonOneLine extends StatefulWidget {
  final List elementsList;
  final int? resvNowSelectingIndex;
  final double customFontSize;
  final Function(int) argCallback;


  SingleOptionTextButtonOneLine({
    required this.elementsList,            // 選択する要素を格納したリスト（※必須）
    this.resvNowSelectingIndex,            // 現在選択中の要素のインデックス番号(デフォでは未選択を示すnull)
    this.customFontSize = 15,                // 選択要素の文字の大きさをカスタム(デフォは15)
    required this.argCallback,             // コールバック関数（※必須）
  });

  @override
  _SingleOptionTextButtonOneLineState createState() =>
      _SingleOptionTextButtonOneLineState();
}

class _SingleOptionTextButtonOneLineState extends State<SingleOptionTextButtonOneLine> {
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
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.elementsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                  top: (index == 0) ? 0 : 7, bottom: 7, right: 10, left: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(130, 58),
                  backgroundColor: (_newSelectIndex == index)
                      ? Color(0xffdedede)
                      : Color(0xfffefefe),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
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
                    SizedBox(width: 6),
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
      ),
    );
  }
}