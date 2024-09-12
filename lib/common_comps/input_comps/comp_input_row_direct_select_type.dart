import 'package:flutter/material.dart';
// 入力フィールド(選択/横直表示形式)単体
// 横に並んだ選択肢から選ばせるコンポーネント
// インポート文：import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_row_direct_select_type.dart';


class CompInputRowDirectSelectType extends StatefulWidget {
  final List<String> elementsList;
  final int? resvNowSelectingIndex;
  final double? customFontSize;
  final double customIconSize;
  final Function(int) argCallback; // コールバック関数
  final double customHeight;

  const CompInputRowDirectSelectType({super.key, 
    required this.elementsList,             // 選択する要素を格納したリスト（※必須）
    this.resvNowSelectingIndex,             // 現在選択中の要素のインデックス番号(デフォでは未選択を示すnull)
    this.customFontSize = 20,               // 選択要素の文字の大きさをカスタム(デフォは20)
    this.customIconSize = 25,
    required this.argCallback,              // コールバック関数（※必須）
    this.customHeight = 62
  });

  @override
  _CompInputRowDirectSelectTypeState createState() => _CompInputRowDirectSelectTypeState();
}

class _CompInputRowDirectSelectTypeState extends State<CompInputRowDirectSelectType> {
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
    return Container(
      height: widget.customHeight,
      margin: const EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.elementsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(right: (index!=(widget.elementsList).length-1) ?18 :0),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(140, 60),
                backgroundColor: (_newSelectIndex == index)
                    ? const Color(0xffdedede)
                    : const Color(0xfffefefe),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                // padding: EdgeInsets.only(left: 2, right: 2)
              ).copyWith(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
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
                    size: widget.customIconSize,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.elementsList[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: widget.customFontSize,
                      color: const Color(0xff444444),
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