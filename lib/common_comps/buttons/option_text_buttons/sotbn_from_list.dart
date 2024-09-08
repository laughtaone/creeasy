import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/buttons/option_text_buttons/single_option_text_button_new.dart';
import 'package:creeasy/COMMON_COMPS/buttons/option_text_buttons/single_option_text_button_new_format.dart';
// リストを受け取りSingleOptionTextButtonNewに反映する

class sotbnFromList extends StatefulWidget {
  final List<SotbProperties> recvSotbsList;
  final Function(List<SotbProperties>) argCallback;

  sotbnFromList({required this.recvSotbsList, required this.argCallback});

  @override
  _sotbnFromListState createState() => _sotbnFromListState();
}

class _sotbnFromListState extends State<sotbnFromList> {
  late List<SotbProperties> _newSotbList;

  @override
  void initState() {
    super.initState();
    _newSotbList = widget.recvSotbsList;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      physics: NeverScrollableScrollPhysics(), // スクロールを無効にする
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 1行に表示する要素数
        childAspectRatio: 0.85, // 各要素のアスペクト比を調整 (幅/高さ)
      ),
      itemCount: _newSotbList.length,
      itemBuilder: (context, index) {
        return SingleOptionTextButtonNew(
          upperText: _newSotbList[index].upperText,
          trueLowerText: _newSotbList[index].trueLowerText,
          falseLowerText: _newSotbList[index].falseLowerText,
          initialBoolLowerText:
              _newSotbList[index].initialBoolLowerText,
          listIndexNum: _newSotbList[index].listIndexNum,
          argCallback: (int index) {
            final bool nowBool =
                _newSotbList[index].initialBoolLowerText;
            setState(() {
              _newSotbList[index] = _newSotbList[index].copyWith(
                initialBoolLowerText: !nowBool,
              );
            });
            widget.argCallback(_newSotbList);
          },
        );
      },
    );
  }
}
