import 'package:flutter/material.dart';
// 入力フィールド(選択/縦直表示形式)単体
// 縦に並んだ選択肢から選ばせるコンポーネント


class CompInputColumnDirectSelectType extends StatefulWidget {
  final List<String> elementsList;
  final int? resvNowSelectingIndex;
  final double customFontSize;
  final double customIconSize;
  final Function(int) argCallback;


  const CompInputColumnDirectSelectType({super.key, 
    required this.elementsList,            // 選択する要素を格納したリスト（※必須）
    this.resvNowSelectingIndex,            // 現在選択中の要素のインデックス番号(デフォでは未選択を示すnull)
    this.customFontSize = 20,                // 選択要素の文字の大きさをカスタム(デフォは15)
    this.customIconSize = 27,
    required this.argCallback,             // コールバック関数（※必須）
  });

  @override
  _CompInputColumnDirectSelectTypeState createState() =>
      _CompInputColumnDirectSelectTypeState();
}

class _CompInputColumnDirectSelectTypeState extends State<CompInputColumnDirectSelectType> {
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
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.elementsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: (index == 0) ? 0 : 7, bottom: 7, right: 13, left: 13),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(130, 65),
                  backgroundColor: (_newSelectIndex == index)
                      ? const Color(0xffdedede)
                      : const Color(0xfffefefe),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 15),
                    Icon(
                      Icons.check,
                      color: (_newSelectIndex == index) ? Colors.black : Colors.white,
                      size: widget.customIconSize,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(
                          widget.elementsList[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: widget.customFontSize,
                            color: const Color(0xff444444),
                            fontWeight: FontWeight.bold,
                          ),
                        )],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}