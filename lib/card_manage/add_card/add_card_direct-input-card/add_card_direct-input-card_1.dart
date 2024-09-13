import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/save_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_button_toggle_comp.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info_end_page_jump.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info_end_url_jump.dart';
import 'package:creeasy/card_manage/card_manage_COMPS/pay_bank_and_saving_box_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_double_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_string_type.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/between/between_select_field.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/between/between_icon.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_row_direct_select_type.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/made_comp/next_button_comp.dart';
import 'package:creeasy/card_manage/add_card/add_card_direct-input-card/add_card_direct-input-card_2.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/progress_bar_comp.dart';





class AddCardPageDirectInputCard1 extends StatefulWidget {
  const AddCardPageDirectInputCard1({super.key});

  @override
  _AddCardPageDirectInputCard1State createState() =>
      _AddCardPageDirectInputCard1State();
}

class _AddCardPageDirectInputCard1State
    extends State<AddCardPageDirectInputCard1> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _dayList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '末日'
  ];

  final List<String> _bankList = ['三菱UFJ銀行', 'みんなの銀行', '三井住友銀行'];
  final List<String> _savingboxList = ['みんなの銀行 - 三井住友カード', 'みんなの銀行 - ビューカード'];

  // ================================ 変数処理 ================================
  String? _inputCardName;
  String? _inputReturnRate;
  int? _isSpecialPayment;
  int? _closingDate; // ③で入力された締め日を保持する変数
  int? _payDate; // ④で入力された引き落とし日を保持する変数
  int? _selectedBankIndex; // ⑤で選択された銀行を保持する変数
  int? _selectedPointUpIndex;   // ⑥で選択されたポイントアップの有無を保持する変数
  int? _selectedBoolSavingboxIndex;
  int? _selectedSavingboxIndex;


  void _onBoolPointUpSelected(int? index) {
    setState(() {
      _selectedPointUpIndex = index;
    });
    print("Selected index: $_selectedPointUpIndex");
  }
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_card_outlined, color: Colors.black),
              SizedBox(width: 5),
              Text(
                'カードを追加',
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ))
          ],
        ),
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
                padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
                child: ListView(
                  children: [
                    progressBarComp(ratioProg: 1, ratioNotprog: 2),
                    // ==================================================== 1.基本項目 ====================================================
                    titleTextComp(resvText: 'Step1：基本項目', hTextType: 1, customBottomMargin: 15),
                    // ------------------------------- ①カード名 -------------------------------
                    selectTileComp(
                      titleComp: titleTextComp(resvIcon: Icons.credit_card_outlined, resvText: 'カード名を入力'),
                      fieldInput: Container(child: compInputStringType(
                        resvNowInputingString: _inputCardName,
                        argCallback: (recvString) {
                          setState(() {
                            _inputCardName = recvString; // コールバックで受け取った値を保持
                          });
                        },
                      ))
                    ),
                    // ------------------------------------------------------------------------
                    // ------------------------------- ②締め日 -------------------------------
                    betweenSelectField(),
                    selectTileComp(
                      titleComp: titleTextComp(resvIcon: Icons.event_outlined, resvText: '締め日を入力'),
                      fieldInput: Container(
                        child: compInputDialogSelectType(
                          dialogText: '締日を選択：',
                          suffixTanni: '日',
                          elementsList: _dayList,
                          resvNowSelectingIndex: _closingDate,
                          argCallback: (date) {
                            setState(() {
                              _closingDate = date;
                            });
                          },
                        ),
                      )
                    ),
                    // ------------------------------------------------------------------------
                    // ------------------------------- ③引き落とし日 -------------------------------
                    betweenSelectField(),
                    selectTileComp(
                      titleComp: titleTextComp(resvIcon: Icons.event_outlined, resvText: '引き落とし日を入力'),
                      fieldInput: Container(
                        child: compInputDialogSelectType(
                          dialogText: '引き落とし日を選択：',
                          suffixTanni: '日',
                          elementsList: _dayList,
                          resvNowSelectingIndex: _payDate,
                          argCallback: (date) {
                            setState(() {
                              _payDate = date;
                            });
                          },
                        ),
                      )
                    ),
                    // ------------------------------------------------------------------------
                    // ------------------------- ④引き落とし口座の選択 ----------------------------
                    betweenSelectField(),
                    PayBankAndSavingBoxComp(
                      // ------------ 引き落とし口座選択フィールド ------------
                      bankList: _bankList,
                      resvNowSelectingBankIndex: _selectedBoolSavingboxIndex,
                      argMainCallback: (int? resvIndex) {
                        setState(() {
                          _selectedBankIndex = resvIndex;
                        });
                      },
                      // --------- 資金ボックスで一旦管理選択フィールド ---------
                      resvNowSelectingSub1: _selectedSavingboxIndex,
                      argSub1Callback: (int? resvIndex) {
                        setState(() {
                          _selectedBoolSavingboxIndex = resvIndex;
                        });
                      },
                      // ------------- 資金ボックス選択フィールド -------------
                      savingboxList: _savingboxList,
                      resvNowSelectingSub2: _selectedSavingboxIndex,
                      argSub2Callback: (int? resvIndex) {
                        setState(() {
                          _selectedSavingboxIndex = resvIndex;
                        });
                      },
                    ),
                    // ------------------------------------------------------------------------
                    // ==================================================================================================================


                    // =============================================== 「次へ」ボタン ==============================================
                    betweenSelectField(customHeight: 20),
                    NextButtonComp(
                      argOnpressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCardPageDirectInputCard2(),
                          ),
                        );
                      },
                    ),
                    // =======================================================================================================
                  ],
                ))));
  }
}
