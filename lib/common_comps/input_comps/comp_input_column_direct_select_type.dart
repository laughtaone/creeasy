import 'package:flutter/material.dart';


// 縦に並んだ選択肢から選ばせるコンポーネント
class SingleOptionTextButtonOneLine extends StatefulWidget {
  final List textList;
  final Function(int?) onItemSelected;
  final double textFontSize;

  SingleOptionTextButtonOneLine({
    required this.textList,
    required this.onItemSelected,
    this.textFontSize = 15, // textFonSizeだけデフォ値を設定
  });

  @override
  _SingleOptionTextButtonOneLineState createState() =>
      _SingleOptionTextButtonOneLineState();
}

class _SingleOptionTextButtonOneLineState extends State<SingleOptionTextButtonOneLine> {
  int? selectedIndex; // 選択中の要素のインデックス

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.textList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
                top: (index == 0) ? 0 : 7, bottom: 7, right: 10, left: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(130, 58),
                backgroundColor: (selectedIndex == index)
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
                  selectedIndex = index;
                });
                widget.onItemSelected(index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color:
                        (selectedIndex == index) ? Colors.black : Colors.white,
                  ),
                  SizedBox(width: 6),
                  Text(
                    widget.textList[index],
                    style: TextStyle(
                      fontSize: widget.textFontSize,
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