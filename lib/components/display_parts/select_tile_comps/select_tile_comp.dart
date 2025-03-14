import 'package:flutter/material.dart';
// 選択タイル
// import文：import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';


class selectTileComp extends StatefulWidget {
  final Widget titleComp;
  final Column? guides;
  final Widget fieldInput;
  final Color customBackColor;
  final Column? beginningGuides;
  final List<double> customTBPadding;

  const selectTileComp({super.key,
    required this.titleComp, // コンポーネントtitleTextCompを指定（必須・引数  IconData? resvIcon, String resvText(デフォは''), double resvTextSize(デフォは18)）
    this.guides, // ColumnのchildrenでminiInfoを並べる（任意）
    required this.fieldInput, // ユーザーからの入力フィールドを指定（必須・入力フィールドのコンポーネントの指定を推奨）
    this.customBackColor = const Color(0xffededed), // カスタム背景色（任意・デフォで色を設定済み）
    this.beginningGuides,      // titleCompの前の冒頭にminiInfoのColumn(任意)
    this.customTBPadding = const [15, 12]
  });

  @override
  _selectTileCompState createState() => _selectTileCompState();
}

class _selectTileCompState extends State<selectTileComp> {
  int? selectedIndex; // 選択中の要素のインデックス

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 9, right: 9, top: widget.customTBPadding[0], bottom: widget.customTBPadding[1]),
      margin: EdgeInsets.only(top: (widget.titleComp==const SizedBox.shrink() || widget.beginningGuides==null) ? 0 : 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.customBackColor,
      ),
      child: Column(
        children: [
          (widget.beginningGuides) ?? const SizedBox.shrink(),
          (widget.beginningGuides==null) ? const SizedBox.shrink() : const SizedBox(height: 10),
          widget.titleComp,
          widget.guides ?? const SizedBox(height: 5),
          widget.fieldInput
        ],
      ),
    );
  }
}