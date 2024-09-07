import 'package:flutter/material.dart';
// 入力フィールド(選択/直表示形式)単体


class compInputDirectSelectType extends StatefulWidget {
  final List elementsList;
  final int? resvNowSelectingIndex;
  final double customFontSize;

  compInputDirectSelectType(
      {required this.elementsList,
      required this.resvNowSelectingIndex,
      this.customFontSize = 15});

  @override
  _compInputDirectSelectTypeState createState() =>
      _compInputDirectSelectTypeState();
}

class _compInputDirectSelectTypeState extends State<compInputDirectSelectType> {
  // -------------------------------- 変数処理 --------------------------------
  late int? _selectedIndex; // 新しく選択した要素のインデックス番号

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.resvNowSelectingIndex; // 初期化処理
  }

  void _onBoolSelected(int? index) {
    setState(() {
      _selectedIndex = index;
    });
    print("Selected index: $_selectedIndex");
  }

  // -------------------------------------------------------------------------
  int? selectedIndex; // 選択中の要素のインデックス

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
                backgroundColor: (_selectedIndex == index)
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
                  selectedIndex = index;
                });
                // widget.onItemSelected(index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color:
                        (selectedIndex == index) ? Colors.black : Colors.white,
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