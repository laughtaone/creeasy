import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_button_toggle_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_double_type.dart';
import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/between/between_select_field.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:creeasy/COMMON_COMPS/between/between_icon.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_column_direct_select_type.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info_end_url_jump.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/save_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/5tab_folders/card_manage/card_manage_COMPS/selected_card_intro_comp.dart';
import 'package:creeasy/5tab_folders/card_manage/card_manage_COMPS/pay_bank_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/progress_bar_comp.dart';
import 'package:creeasy/5tab_folders/card_manage/card_manage_COMPS/pay_bank_and_saving_box_comp.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/made_comp/next_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/function/judge_all_notnull.dart';
import 'package:creeasy/5tab_folders/card_manage/add_card/add_card_preset-card/add_card_preset-card_2.dart';



class AddCardPagePresetCard1 extends StatefulWidget {
  final String? selectedCardName;

  const AddCardPagePresetCard1({super.key, required this.selectedCardName});

  @override
  _AddCardPagePresetCard1State createState() => _AddCardPagePresetCard1State();
}

class _AddCardPagePresetCard1State extends State<AddCardPagePresetCard1> {

  final List<String> _gradYearList = [
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030'
  ];

  // ================================ 変数処理 ================================
  // --------- 締日・引落日 ---------
  int? _selectedPayRule; // ①で選択された締日/引き落とし日を保持する変数
  final List<String> _smcnlPayRule = ['15日締め / 翌月10日払い', '月末締め / 翌月26日払い'];
  // ---------- 引落口座 -----------
  int? _selectedBankIndex;
  int? _selectedBoolSavingboxIndex;

  int? _selectedSavingboxIndex;
  final List<String> _bankList = ['三菱UFJ銀行', 'みんなの銀行', '三井住友銀行'];
  final List<String> _savingboxList = ['みんなの銀行1 - 三井住友カード', 'みんなの銀行2 - ビューカード'];


  int? _selectedBank; // ②で選択された銀行を保持する変数
  int? _selectedVpupIndex; // ③で入力されたVPUPの有無を保持する変数
  String? _inputVpupReturnRate; // ③で入力された還元率[%]を保持する変数
  int? _selectedStudentPointIndex; // ④で入力された学生ポイントの有無を保持する変数
  int? _selectedGradYear;           // ④で入力された卒業予定年のインデックスを保持する変数
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
              child: ListView(children:[
                progressBarComp(ratioProg: 1, ratioNotprog: 1),
                // =============================================== ⓪ 選択されたカード名 ==============================================
                const SizedBox(height: 5),
                selectedCardIntro(widget.selectedCardName),
                // =======================================================================================================

                betweenIcon(recvIcon: Icons.add_outlined),

                // =============================================== ① 締日/引き落とし日の選択 ==============================================
                titleTextComp(resvText: 'Step1：基本項目', hTextType: 1, customBottomMargin: 15),
                selectTileComp(
                  titleComp: titleTextComp(
                      resvIcon: Icons.event_outlined, resvText: '締日/引き落とし日を選択'),
                  guides: Column(
                    children: [
                      miniInfo(passText: '公式サイトの情報を基に作成しています'),
                      miniInfo(passText: '設定できるはずの日付が用意されていない場合は、お手数ですが開発者までご連絡ください'),
                    ],
                  ),
                  fieldInput: CompInputColumnDirectSelectType(
                    elementsList: _smcnlPayRule,
                    customFontSize: 17,
                    resvNowSelectingIndex: _selectedPayRule,
                    argCallback: (int? recvIndex) {
                      setState(() {
                        _selectedPayRule = recvIndex;
                      });
                    },
                  ),
                ),
                // =======================================================================================================

                // ========================================== ②引き落とし口座 ==========================================
                betweenSelectField(),
                Text(_selectedSavingboxIndex.toString()),
                PayBankAndSavingBoxComp(
                  // ------------ 引き落とし口座選択フィールド ------------
                  bankList: _bankList,
                  resvNowSelectingBankIndex: _selectedBankIndex,
                  argMainCallback: (int? resvIndex) {
                    _selectedBankIndex = resvIndex;
                    setState(() {
                      _selectedBankIndex = resvIndex;
                    });
                  },
                  // --------- 資金ボックスで一旦管理選択フィールド ---------
                  resvNowSelectingSub1: _selectedBoolSavingboxIndex,
                  argSub1Callback: (int? resvIndex) {
                    _selectedBoolSavingboxIndex = resvIndex;
                    setState(() {
                      _selectedBoolSavingboxIndex = resvIndex;
                    });
                  },
                  // ------------- 資金ボックス選択フィールド -------------
                  savingboxList: _savingboxList,
                  resvNowSelectingSub2: _selectedSavingboxIndex,
                  argSub2Callback: (int? resvIndex) {
                    _selectedSavingboxIndex = resvIndex;
                    setState(() {
                      _selectedSavingboxIndex = resvIndex;
                    });
                  },
                ),
                // ====================================================================================================

                // =============================================== 「次へ」ボタン ==============================================
                betweenSelectField(customHeight: 40),
                NextButtonComp(
                  isCanPressNextButton: (judgeAllNotnull(rectList: [
                    _selectedPayRule,
                    _selectedBankIndex,
                    _selectedBoolSavingboxIndex,
                    // isInputToggleAllField(_selectedBoolSavingboxIndex, _selectedSavingboxIndex)
                  ])) ?true :false,
                  argOnpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCardPageDirectInputCard2(selectedCardName: widget.selectedCardName),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40)
                // =======================================================================================================
              ]))),
    );
  }
}
