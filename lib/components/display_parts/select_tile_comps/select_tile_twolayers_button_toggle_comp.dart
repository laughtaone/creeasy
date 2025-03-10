import 'package:creeasy/components/display_parts/title_text_comp.dart';
import 'package:creeasy/components/input_comps/comp_input_row_direct_select_type.dart';
import 'package:creeasy/components/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:flutter/material.dart';
// 選択タイル
// import文：import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_twolayers_button_toggle_comp.dart';




class SelectTileTwolayersButtonToggleComp extends StatefulWidget {
  // ================== メインフィールド(必須) ==================
  final Widget mainTitleComp;
  final Column? mainGuides;
  // ------------ メインの入力欄 ------------
  final List<String> mainSelectList;
  final int? nowMainSelectButtonIndex;
  final Function(int?) argMainCallback;
  final double customMainSelectHeight;
  // ================ メインフィールド(カスタム) ================
  final Column? mainBeginningGuides;
  final Color mainCustomBackColor;
  final Column? beginningMainGuides;
  final double customFontsizeMainButton;
  final double customIconsizeMainButton;
  // ===================== サブフィールド ======================
  final bool defaultOpenSub;
  final Column? subBeginningGuides;
  final Widget subTitleComp;
  final Column? subGuides;
  final double? customBetweenSub1And2;
  // ----------- サブ1の横並びボタン -----------
  final List<String> sub1SelectList;
  final int? nowSub1SelectButtonIndex;
  final Function(int?) argSub1Callback;
  final double customFontsizeSub1Button;
  final double customIconsizeSub1Button;
  final double customSub1Height;
  // ---------- サブ2の入力フィールド ----------
  final bool defaultOpenSub2Toggle;
  final Widget sub2FieldInput;
  // final Function argToggleCallback;
  // -----------------------------------------

  const SelectTileTwolayersButtonToggleComp({super.key,
    // ================== メインフィールド(必須) ==================
    required this.mainTitleComp,
    this.mainGuides,
    // ------------ メインの入力欄 ------------
    required this.mainSelectList,
    required this.nowMainSelectButtonIndex,
    required this.argMainCallback,
    this.customMainSelectHeight = 60,
    // ================ メインフィールド(カスタム) ================
    this.mainBeginningGuides,
    this.mainCustomBackColor = const Color(0xffededed),
    this.beginningMainGuides,
    this.customFontsizeMainButton = 20,
    this.customIconsizeMainButton = 28,
    // ===================== サブフィールド ======================
    this.defaultOpenSub = false,
    this.subBeginningGuides,
    required this.subTitleComp,
    this.subGuides,
    this.customBetweenSub1And2,
    // ----------- サブ1の横並びボタン -----------
    required this.sub1SelectList,
    required this.nowSub1SelectButtonIndex,
    required this.argSub1Callback,
    this.customFontsizeSub1Button = 20,
    this.customIconsizeSub1Button = 28,
    this.customSub1Height = 60,
    // ---------- サブ2の入力フィールド ----------
    this.defaultOpenSub2Toggle = false,
    required this.sub2FieldInput,
    // final Function argToggleCallback;
    // -----------------------------------------
  });

  @override
  _SelectTileTwolayersButtonToggleCompState createState() => _SelectTileTwolayersButtonToggleCompState();
}

class _SelectTileTwolayersButtonToggleCompState extends State<SelectTileTwolayersButtonToggleComp> {
  // -------------------------------- 変数処理 --------------------------------
  int? _newMainSelectbuttonIndex; // 選択中の要素のインデックス
  int? _newSub1SelectButtonIndex;

  @override
  void initState() {
    super.initState();
    _newMainSelectbuttonIndex = widget.nowMainSelectButtonIndex;
    _newSub1SelectButtonIndex = widget.nowSub1SelectButtonIndex;
  }
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return selectTileComp(
      beginningGuides: widget.beginningMainGuides,
      titleComp: widget.mainTitleComp,
      guides: widget.mainGuides,
      fieldInput: Container(
        margin: const EdgeInsets.all(0),
        child: Column(
          children: [
            CompInputRowDirectSelectType(
              elementsList: widget.mainSelectList,
              customFontSize: widget.customFontsizeMainButton,
              customIconSize: widget.customIconsizeMainButton,
              resvNowSelectingIndex: _newMainSelectbuttonIndex,
              argCallback: (int? recvIndex) {
                setState(() {
                  _newMainSelectbuttonIndex = recvIndex;
                });
                widget.argMainCallback(_newMainSelectbuttonIndex);
              },
              customHeight: widget.customMainSelectHeight,
            ),
            (_newMainSelectbuttonIndex == 1 || widget.defaultOpenSub==true)
            ? Column(
              children: [
                const SizedBox(height: 7),
                selectTileComp(
                  customBackColor: const Color(0xffdcdcdc),
                  beginningGuides: widget.subBeginningGuides,
                  titleComp: widget.subTitleComp,
                  guides: widget.subGuides,
                  fieldInput: Container(
                    child: Column(
                      children: [
                        CompInputRowDirectSelectType(
                          elementsList: widget.sub1SelectList,
                          customFontSize: widget.customFontsizeSub1Button,
                          customIconSize: widget.customIconsizeSub1Button,
                          resvNowSelectingIndex: _newSub1SelectButtonIndex,
                          argCallback: (int? recvIndex) {
                            setState(() {
                              _newSub1SelectButtonIndex = recvIndex;
                            });
                            widget.argSub1Callback(_newSub1SelectButtonIndex);
                          },
                          customHeight: widget.customSub1Height,
                          customSelectedColor: const Color(0xffc4c4c4),
                        ),
                        SizedBox(height: widget.customBetweenSub1And2),
                        (_newSub1SelectButtonIndex == 1 || widget.defaultOpenSub2Toggle==true)
                          ? widget.sub2FieldInput
                          : const SizedBox.shrink()
                      ],
                    ),
                  )
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