import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/add_bank/add_bank_main.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info_end_page_jump.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_button_toggle_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_row_direct_select_type.dart';
// 引き落とし口座の選択(資金ボックスで管理するかどうか聞く)
// import文：import 'package:creeasy/card_manage/card_manage_COMPS/pay_bank_and_saving_box_comp.dart';




class PayBankAndSavingBoxComp extends StatefulWidget {
  // ------------ 引き落とし口座選択フィールド ------------
  final List<String> bankList;
  final Function(int?) argMainCallback;
  final int? resvNowSelectingBankIndex;
  // --------- 資金ボックスで一旦管理選択フィールド ---------
  final Function(int?) argSub1Callback;
  final int? resvNowSelectingSub1;
  // ------------- 資金ボックス選択フィールド -------------
  final List<String>? savingboxList;
  final Function(int?) argSub2Callback;
  final int? resvNowSelectingSub2;
  // -------------------- カスタム系 --------------------
  final Color mainCustomBackColor;
  final double customFontsizeMainSelectButton;
  final double customIconsizeMainSelectButton;
  final double customSelectButtonHeight;


  const PayBankAndSavingBoxComp({super.key,
    // ------------ 引き落とし口座選択フィールド ------------
    required this.bankList,
    required this.argMainCallback,
    required this.resvNowSelectingBankIndex,
    // --------- 資金ボックスで一旦管理選択フィールド ---------
    required this.argSub1Callback,
    required this.resvNowSelectingSub1,
    // ------------- 資金ボックス選択フィールド -------------
    required this.savingboxList,
    required this.argSub2Callback,
    required this.resvNowSelectingSub2,
    // -------------------- カスタム系 --------------------
    this.mainCustomBackColor = const Color(0xffededed), // カスタム背景色（任意・デフォで色を設定済み）
    this.customFontsizeMainSelectButton = 17,
    this.customIconsizeMainSelectButton = 24,
    this.customSelectButtonHeight = 60,
  });

  @override
  _PayBankAndSavingBoxCompState createState() => _PayBankAndSavingBoxCompState();
}

class _PayBankAndSavingBoxCompState extends State<PayBankAndSavingBoxComp> {
  // -------------------------------- 変数処理 --------------------------------
  int? _newMainSelectbuttonIndex; // 選択中の要素のインデックス
  int? _newSelectSub1Index;
  int? _newSelectSub2Index;

  @override
  void initState() {
    super.initState();
    _newMainSelectbuttonIndex = widget.resvNowSelectingBankIndex;
    _newSelectSub1Index  = widget.resvNowSelectingSub1;
    _newSelectSub2Index = widget.resvNowSelectingSub2;
  }
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return selectTileComp(
      titleComp: titleTextComp(resvIcon: Icons.account_balance_outlined, resvText: '引き落とし口座を選択'),
      guides: const Column(children: [miniInfoEndPageJump(passText: '銀行を新規追加する場合は', jumpPage: AddBankPage())]),
      fieldInput: Container(
        // margin: EdgeInsets.all(10),
        margin: const EdgeInsets.all(0),
        child: Column(
          children: [
            // CompInputRowDirectSelectType(
            //   elementsList: widget.mainSelectList,
            //   customFontSize: widget.customFontsizeMainSelectButton,
            //   customIconSize: widget.customIconsizeMainSelectButton,
            //   resvNowSelectingIndex: _newMainSelectbuttonIndex,
            //   argCallback: (int? recvIndex) {
            //     setState(() {
            //       _newMainSelectbuttonIndex = recvIndex;
            //     });
            //     widget.argMainCallback(_newMainSelectbuttonIndex);
            //   },
            //   customHeight: widget.customSelectButtonHeight,
            // ),
            // ================================ 引き落とし口座選択フィールド ================================
            compInputDialogSelectType(
              elementsList: widget.bankList,
              resvNowSelectingIndex: _newMainSelectbuttonIndex,
              dialogText: '引き落とし口座を選択',
              argCallback: widget.argMainCallback,
            ),
            // ==========================================================================================
            // ========================= 資金ボックスで一旦管理するかどうかのフィールド =========================
            Column(
              children: [
                const SizedBox(height: 7),
                selectTileComp(
                  customBackColor: const Color(0xffd8d8d8),
                  titleComp: titleTextComp(resvIcon: Icons.account_balance_outlined, resvText: '資金ボックスで一旦管理しますか？'),
                  // guides: widget.toggleGuides,
                  fieldInput: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: CompInputRowDirectSelectType(
                            customSelectedColor: const Color(0xffc4c4c4),
                            customNonselectedColor: const Color(0xfff1f1f1),
                            elementsList: const ['する', 'しない'],
                            //   argCallback: (int? recvIndex) {
                            //     setState(() {
                            //       _newMainSelectbuttonIndex = recvIndex;
                            //     });
                            //     widget.argMainCallback(_newMainSelectbuttonIndex);
                            //   },

                            // argCallback: widget.argSub1Callback,
                            argCallback: (int resvIndex) {
                              setState(() {
                                switch (resvIndex) {
                                  case 0:
                                    _newSelectSub1Index = 1;
                                    break;
                                  case 1:
                                    _newSelectSub1Index = 0;
                                    break;
                                  default:
                                    throw ArgumentError('【An error I created】error.');
                                }
                              });
                              widget.argSub1Callback(_newSelectSub1Index);
                            },
                          ),
                        ),
                        (_newSelectSub1Index==1)
                          ? Container(
                              child: selectTileComp(
                                customBackColor: const Color(0xffc0c0c0),
                                titleComp: titleTextComp(resvText: '資金ボックスを選択'),
                                fieldInput: compInputDialogSelectType(
                                  elementsList: widget.savingboxList ?? [''],
                                  resvNowSelectingIndex: _newSelectSub2Index,
                                  dialogText: '資金ボックスを選択',
                                  argCallback: widget.argSub2Callback,
                                  customBackColor: const Color(0xfff0f0f0),
                                ),
                              ),
                            )
                          : const SizedBox.shrink()
                      ],
                    ),
                  )
                ),
              ],
            )
            // ==========================================================================================
          ],
        ),
      ),
    );
  }
}