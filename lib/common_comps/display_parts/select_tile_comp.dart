import 'package:flutter/material.dart';
// 選択タイル


class selectTileComp extends StatefulWidget {
  final Widget titleComp;
  final Column? guides;
  final Container fieldInput;
  final Color customBackColor;
  final Column? beginningGuides;

  selectTileComp(
      {required this.titleComp, // コンポーネントtitleTextCompを指定（必須・引数  IconData? resvIcon, String resvText(デフォは''), double resvTextSize(デフォは18)）
      this.guides, // ColumnのchildrenでminiInfoを並べる（任意）
      required this.fieldInput, // ユーザーからの入力フィールドを指定（必須・入力フィールドのコンポーネントの指定を推奨）
      this.customBackColor = const Color(0xffededed), // カスタム背景色（任意・デフォで色を設定済み）
      this.beginningGuides      // titleCompの前の冒頭にminiInfoのColumn(任意)
      });

  @override
  _selectTileCompState createState() => _selectTileCompState();
}

class _selectTileCompState extends State<selectTileComp> {
  int? selectedIndex; // 選択中の要素のインデックス

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.customBackColor,
      ),
      child: Column(
        children: [
          (widget.beginningGuides) ?? const SizedBox.shrink(),
          (widget.beginningGuides==null) ? const SizedBox.shrink() : SizedBox(height: 10),
          widget.titleComp,
          widget.guides ?? const SizedBox(height: 5),
          widget.fieldInput
        ],
      ),
    );
  }
}