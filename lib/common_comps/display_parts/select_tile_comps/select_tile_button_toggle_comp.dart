import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_row_direct_select_type.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:flutter/material.dart';
// 選択タイル
// import文：import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_button_toggle_comp.dart';


class selectTileButtonToggleComp extends StatefulWidget {
  final Widget mainTitleComp;
  final Column? mainGuides;
  // final Container mainFieldInput;
  final Color mainCustomBackColor;
  final Column? beginningMainGuides;
  final Function(int?) argMainCallback;
  final List<String> mainSelectList;
  final double customFontsizeMainSelectButton;
  final double customIconsizeMainSelectButton;
  final int? nowMainSelectbuttonIndex;
  final double customSelectButtonHeight;
  final bool defalutOpenToggle;
  // ------------ トグルフィールド --------------
  final Column? toggleBeginningGuides;
  final Widget? toggleTitleComp;
  final Column? toggleGuides;
  final Widget toggleFieldInput;
  // final Function argToggleCallback;
  // -----------------------------------------

  const selectTileButtonToggleComp({super.key,
    required this.mainTitleComp, // コンポーネントtitleTextCompを指定（必須・引数  IconData? resvIcon, String resvText(デフォは''), double resvTextSize(デフォは18)）
    this.mainGuides, // ColumnのchildrenでminiInfoを並べる（任意）
    // required this.mainFieldInput, // ユーザーからの入力フィールドを指定（必須・入力フィールドのコンポーネントの指定を推奨）
    this.mainCustomBackColor = const Color(0xffededed), // カスタム背景色（任意・デフォで色を設定済み）
    this.beginningMainGuides,      // mainTitleCompの前の冒頭にminiInfoのColumn(任意)
    required this.argMainCallback,
    required this.mainSelectList,
    this.customFontsizeMainSelectButton = 17,
    this.customIconsizeMainSelectButton = 24,
    required this.nowMainSelectbuttonIndex,
    this.customSelectButtonHeight = 60,
    this.defalutOpenToggle = false,
    // ------------ トグルフィールド --------------
    this.toggleBeginningGuides,
    this.toggleTitleComp,
    this.toggleGuides,
    required this.toggleFieldInput,
    // required this.argToggleCallback,
    // -----------------------------------------
  });

  @override
  _selectTileButtonToggleCompState createState() => _selectTileButtonToggleCompState();
}

class _selectTileButtonToggleCompState extends State<selectTileButtonToggleComp> {
  // -------------------------------- 変数処理 --------------------------------
  int? _newMainSelectbuttonIndex; // 選択中の要素のインデックス

  @override
  void initState() {
    super.initState();
    _newMainSelectbuttonIndex = widget.nowMainSelectbuttonIndex;
  }
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return selectTileComp(
      beginningGuides: widget.beginningMainGuides,
      titleComp: widget.mainTitleComp,
      guides: widget.mainGuides,
      fieldInput: Container(
        // margin: EdgeInsets.all(10),
        margin: const EdgeInsets.all(0),
        child: Column(
          children: [
            CompInputRowDirectSelectType(
              elementsList: widget.mainSelectList,
              customFontSize: widget.customFontsizeMainSelectButton,
              customIconSize: widget.customIconsizeMainSelectButton,
              resvNowSelectingIndex: _newMainSelectbuttonIndex,
              argCallback: (int? recvIndex) {
                setState(() {
                  _newMainSelectbuttonIndex = recvIndex;
                });
                widget.argMainCallback(_newMainSelectbuttonIndex);
              },
              customHeight: widget.customSelectButtonHeight,
            ),
            (_newMainSelectbuttonIndex == 1 || widget.defalutOpenToggle==true)
            ? Column(
              children: [
                const SizedBox(height: 7),
                selectTileComp(
                  customBackColor: const Color(0xffdcdcdc),
                  beginningGuides: widget.toggleBeginningGuides,
                  titleComp: widget.toggleTitleComp ?? const SizedBox.shrink(),
                  guides: widget.toggleGuides,
                  fieldInput: widget.toggleFieldInput
                ),
              ],
            )
            : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}