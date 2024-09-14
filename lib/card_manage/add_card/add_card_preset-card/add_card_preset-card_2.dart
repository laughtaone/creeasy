import 'package:auto_size_text/auto_size_text.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_button_toggle_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_double_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_row_direct_select_type.dart';
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
import 'package:creeasy/card_manage/card_manage_COMPS/selected_card_intro_comp.dart';
import 'package:creeasy/card_manage/card_manage_COMPS/pay_bank_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/progress_bar_comp.dart';
import 'package:creeasy/card_manage/card_manage_COMPS/pay_bank_and_saving_box_comp.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/made_comp/next_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/function/judge_all_notnull.dart';
import 'package:creeasy/card_manage/card_manage_COMPS/must_manage_lists_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_twolayers_button_toggle_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/basic_text.dart';



class AddCardPageDirectInputCard2 extends StatefulWidget {
  final String? selectedCardName;

  const AddCardPageDirectInputCard2({super.key, required this.selectedCardName});

  @override
  _AddCardPageDirectInputCard2State createState() => _AddCardPageDirectInputCard2State();
}

class _AddCardPageDirectInputCard2State extends State<AddCardPageDirectInputCard2> {

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
  // ------- 基本還元ポイント --------
  int? _selectBoolManageBacisReturn;
  // ------------ VPUP ------------
  int? _isManageVpupIndex;
  String? _inputVpupReturnRate; // VPUP還元率[%]を保持する変数
  // --------- 学生ポイント ---------
  int? _isExistStudentPoint;
  int? _isManageStudentPoint;


  int? _selectedSavingboxIndex;
  final List<String> _bankList = ['三菱UFJ銀行', 'みんなの銀行', '三井住友銀行'];
  final List<String> _savingboxList = ['みんなの銀行1 - 三井住友カード', 'みんなの銀行2 - ビューカード'];


  int? _selectedBank; // ②で選択された銀行を保持する変数
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
                // --------------------------- ⓪必須項目 ----------------------------
                titleTextComp(resvText: 'Step2：管理項目', hTextType: 1, customBottomMargin: 15),
                mustManageListComp(),
                // ------------------------------------------------------------------------

                betweenIcon(recvIcon: Icons.add_outlined),

                // --------------------------- ①基本還元率 ----------------------------
                selectTileComp(
                  titleComp: titleTextComp(resvIcon: Icons.card_giftcard_outlined, resvText: '基本還元ポイントの管理'),
                  guides: Column(children: [
                    miniInfo(passText: '基本還元ポイントとは、利用金額に対して一定の割合で付与されるポイントです'),
                    miniInfo(passText: 'この時の割合が「基本還元率」です', needsIcon: false),
                    basicText(recvText: '基本還元分のポイントを管理しますか？'),
                  ]),
                  fieldInput: CompInputRowDirectSelectType(
                    elementsList: const ['しない', 'する'],
                    resvNowSelectingIndex: _selectBoolManageBacisReturn,
                    argCallback: (int? recvIndex) {
                      _selectBoolManageBacisReturn = recvIndex;
                    }
                  ),
                ),
                // ------------------------------------------------------------------------

                // ---------------------------- ②VPUP ------------------------------------
                betweenSelectField(),
                selectTileButtonToggleComp(
                  mainTitleComp: titleTextComp(resvIcon: Icons.local_offer_outlined, resvText: 'Vポイントアッププログラムの管理', resvTextSize: 17),
                  mainGuides: Column(children: [
                    miniInfoEndUrlJump(passText: 'Vポイントアッププログラムの詳細は', passUrl: 'https://www.smbc-card.com/mem/wp/vpoint_up_program/index.jsp'),
                    miniInfo(passText: 'ポイント還元も詳細に管理することが可能'),
                    miniInfo(passText: '利用金額のみを管理したい場合はこの設定は不要', customIcon: Icons.tips_and_updates_outlined),
                    miniInfo(passText: 'ポイントも細かく管理したい方におすすめ', customIcon: Icons.tips_and_updates_outlined),
                    basicText(recvText: 'VPUプログラムのポイントを管理しますか？')
                  ],),
                  mainSelectList: const ['しない', 'する'],
                  customIconsizeMainSelectButton: 27,
                  customFontsizeMainSelectButton: 20,
                  nowMainSelectbuttonIndex: _isManageVpupIndex,
                  argMainCallback: (int? resvIndex) {
                    _isManageVpupIndex = resvIndex;
                  },
                  toggleGuides: Column(children: [
                    // --------------------------- 【展開時】VPUP還元率の注意書き -----------------------------------
                    miniInfo(passText: '0-20[%] の 整数または小数 が設定可能'),
                    miniInfo(passText: '表示されている還元率は基本還元率0.5%を含みますが、無視してそのまま入力してください'),
                    basicText(
                      recvText: 'Vpassアプリに表示されているVポイントアッププログラムの還元率をそのまま入力',
                      customTBPadding: [10, 0],
                      customLRPadding: [5, 5]
                    ),
                    // ----------------------------------------------------------------------------------------------
                  ],),
                  toggleFieldInput: Container(
                    child: compInputDoubleType(
                      suffixText: '%',
                      resvNowInputingDouble: (_inputVpupReturnRate != null) ? double.tryParse(_inputVpupReturnRate!) : null,
                      argCallback: (String? recvString) {
                        setState(() {
                          _inputVpupReturnRate = recvString;
                        });
                      },
                    ),
                  ),
                ),
                // ------------------------------------------------------------------------

                // =============================================== 学生ポイント ==============================================
                betweenSelectField(),
                SelectTileTwolayersButtonToggleComp(
                  mainTitleComp: titleTextComp(resvIcon: Icons.school_outlined, resvText: '学生ポイント'),
                  mainGuides: Column(children: [
                    miniInfoEndUrlJump(passText: '学生ポイントの詳細は', passUrl:'https://www.smbc-card.com/mem/wp/student-point/index.jsp'),
                    miniInfo(passText: '学生ポイント還元も詳細に管理することが可能'),
                    miniInfo(passText: '利用金額のみを管理したい場合この設定は不要', customIcon: Icons.tips_and_updates_outlined),
                    miniInfo(passText: 'ポイントも細かく管理したい方におすすめ', customIcon: Icons.tips_and_updates_outlined),
                  ]),
                  mainSelectList: const ['ない', 'ある'],
                  nowMainSelectButtonIndex: _isExistStudentPoint,
                  argMainCallback: (int? resvIndex) {
                    _isExistStudentPoint = resvIndex;
                    setState(() {_isExistStudentPoint = resvIndex;});
                  },
                  subTitleComp: titleTextComp(resvText: '学生ポイントのポイントまで管理しますか？',),
                  subGuides: Column(children: [miniInfo(passText: '細かく管理したい方におすすめ', customIcon: Icons.tips_and_updates_outlined)]),
                  sub1SelectList: const ['しない', 'する'],
                  nowSub1SelectButtonIndex: _isManageStudentPoint,
                  argSub1Callback: (int? resvIndex) {
                    _isManageStudentPoint = resvIndex;
                    setState(() {_isManageStudentPoint = resvIndex;});
                  },
                  customBetweenSub1And2: 10,
                  subBeginningGuides: Column(children: [
                    // --------------------------- 【展開時】学生ポイントの注意書き -----------------------------------
                    miniInfo(passText: '次のポイントが計算可能です：', customIcon: Icons.check),
                    miniInfo(passText: '・LINE Pay還元(最大+9.5%)', needsIcon: false, doukaColor: const Color(0xffdcdcdc)),
                    miniInfo(passText: '・対象サブスク還元(最大+9.5%)', needsIcon: false, doukaColor: const Color(0xffdcdcdc)),
                    miniInfo(passText: '・携帯料金還元(最大+1.5%)', needsIcon: false, doukaColor: const Color(0xffdcdcdc)),
                    miniInfo(passText: '次のポイントは計算できません：', customIcon: Icons.block_outlined),
                    miniInfo(passText: '・分割払い手数料全額ポイント還元', needsIcon: false, doukaColor: const Color(0xffdcdcdc)),
                    // ----------------------------------------------------------------------------------------------
                  ]),
                  sub2FieldInput: selectTileComp(
                    customBackColor: const Color(0xffc0c0c0),
                    titleComp: titleTextComp(resvIcon: Icons.event_available_outlined, resvText: '卒業予定年を入力', resvTextSize: 16),
                    guides: Column(children: [
                      miniInfo(passText: '学生ポイントは、卒業予定年の12月末日分までのため、卒業予定の年部分のみを入力'),
                      miniInfo(passText: '例：2020年3月に卒業式を行い卒業する場合は「2020年」を選択', customIcon: Icons.tips_and_updates_outlined),
                    ]),
                    fieldInput: compInputDialogSelectType(
                      elementsList: _gradYearList,
                      resvNowSelectingIndex: _selectedGradYear,
                      dialogText: '卒業予定年を選択：',
                      mainSuffixText: '年',
                      argCallback: (int? recvIndex) {
                        setState(() {
                          _selectedGradYear = recvIndex;
                        });
                      },
                    ),
                  )
                ),
                // =======================================================================================================


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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const AddCardPageDirectInputCard2(),
                    //   ),
                    // );
                  },
                ),
                betweenSelectField(customHeight: 50),
                // =======================================================================================================


                // =============================================== 保存ボタン ==============================================
                SaveButtonComp(
                  argCallback: () {
                    print('保存されました');
                  },
                  isCanOnpress: true,
                ),
                // =======================================================================================================
              ]))),
    );
  }
}
