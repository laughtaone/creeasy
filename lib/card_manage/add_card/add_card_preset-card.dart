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
import 'package:creeasy/card_manage/card_manage_COMPS/selected_card_intro_comp.dart';
import 'package:creeasy/card_manage/card_manage_COMPS/pay_bank_comp.dart';



class AddCardPagePresetCard extends StatefulWidget {
  final String? selectedCardName;

  const AddCardPagePresetCard({super.key, required this.selectedCardName});

  @override
  _AddCardPagePresetCardState createState() => _AddCardPagePresetCardState();
}

class _AddCardPagePresetCardState extends State<AddCardPagePresetCard> {
  final List<String> _smcnlPayRule = ['15日締め / 翌月10日払い', '月末締め / 翌月26日払い'];
  final List<String> _bankList = ['三菱UFJ銀行', 'みんなの銀行', '三井住友銀行'];
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
  int? _selectedPayRule; // ①で選択された締日/引き落とし日を保持する変数
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
                // =============================================== ⓪ 選択されたカード名 ==============================================
                const SizedBox(height: 5),
                selectedCardIntro(widget.selectedCardName),
                // =======================================================================================================

                betweenIcon(recvIcon: Icons.add_outlined),

                titleTextComp(resvText: 'カード情報を微調整', hTextType: 1),

                // =============================================== ① 締日/引き落とし日の選択 ==============================================
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
                PayBankComp(
                  bankList: _bankList,
                  resvNowSelectingBankIndex: _selectedBank,
                  argCallback: (int? recvIndex) {
                    setState(() {
                      _selectedBank = recvIndex;
                    });
                  },
                ),
                // ====================================================================================================

                // =============================================== ③Vポイントアップの選択 ==============================================
                betweenSelectField(),
                selectTileButtonToggleComp(
                  mainTitleComp: titleTextComp(resvIcon: Icons.local_offer_outlined, resvText: 'Vポイントアッププログラムの還元率', resvTextSize: 16),
                  mainGuides: Column(children: [
                    miniInfoEndUrlJump(passText: 'Vポイントアッププログラムの詳細は', passUrl: 'https://www.smbc-card.com/mem/wp/vpoint_up_program/index.jsp'),
                    miniInfo(passText: 'ポイント還元も詳細に管理することが可能'),
                    miniInfo(passText: '利用金額のみを管理したい場合はこの設定は不要', customIcon: Icons.tips_and_updates_outlined),
                    miniInfo(passText: 'ポイントも細かく管理したい方におすすめ', customIcon: Icons.tips_and_updates_outlined),
                  ],),
                  mainSelectList: const ['設定しない', '設定する'],
                  argMainCallback: (int? resvIndex) {
                    _selectedVpupIndex = resvIndex;
                  },
                  nowMainSelectbuttonIndex: _selectedVpupIndex,
                  toggleGuides: Column(children: [
                    // --------------------------- 【展開時】VPUP還元率の注意書き -----------------------------------
                    miniInfo(passText: 'Vpassアプリに表示されているVポイントアッププログラムの還元率をそのまま入力'),
                    miniInfo(
                      passText:'（表示されている還元率は基本還元率0.5%を含みますが、無視してそのまま入力してください）',
                      customTextSize: 10,
                      needsIcon: false,
                      needsTBPadding: false,
                      doukaColor: const Color(0xffdcdcdc)
                    ),
                    miniInfo(passText: '0-20[%] の 整数または小数 が設定可能'),
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
                // =======================================================================================================

                // =============================================== ④学生ポイントの有無 ==============================================
                betweenSelectField(),
                selectTileButtonToggleComp(
                  mainTitleComp: titleTextComp(resvIcon: Icons.school_outlined, resvText: '学生ポイント'),
                  mainGuides: Column(children: [
                      miniInfoEndUrlJump(passText: '学生ポイントの詳細は', passUrl:'https://www.smbc-card.com/mem/wp/student-point/index.jsp'),
                      miniInfo(passText: '学生ポイント還元も詳細に管理することが可能'),
                      miniInfo(passText: '利用金額のみを管理したい場合この設定は不要', customIcon: Icons.tips_and_updates_outlined),
                      miniInfo(passText: 'ポイントも細かく管理したい方におすすめ', customIcon: Icons.tips_and_updates_outlined),
                  ],),
                  mainSelectList: const ['設定しない', '設定する'],
                  argMainCallback: (int? resvIndex) {
                    _selectedStudentPointIndex = resvIndex;
                  },
                  nowMainSelectbuttonIndex: _selectedStudentPointIndex,
                  toggleBeginningGuides: Column(children: [
                    // --------------------------- 【展開時】学生ポイントの注意書き -----------------------------------
                    miniInfo(passText: '次のポイントが計算可能です：', customIcon: Icons.check),
                    miniInfo(passText: '・LINE Pay還元(最大+9.5%)', needsIcon: false, doukaColor: const Color(0xffdcdcdc)),
                    miniInfo(passText: '・対象サブスク還元(最大+9.5%)', needsIcon: false, doukaColor: const Color(0xffdcdcdc)),
                    miniInfo(passText: '・携帯料金還元(最大+1.5%)', needsIcon: false, doukaColor: const Color(0xffdcdcdc)),
                    miniInfo(passText: '次のポイントは計算できません：', customIcon: Icons.block_outlined),
                    miniInfo(passText: '・分割払い手数料全額ポイント還元', needsIcon: false, doukaColor: const Color(0xffdcdcdc)),
                    // ----------------------------------------------------------------------------------------------
                  ]),
                  toggleTitleComp: titleTextComp(resvIcon: Icons.event_available_outlined, resvText: '卒業予定年を入力', resvTextSize: 16),
                  toggleGuides: Column(children: [
                    miniInfo(passText: '学生ポイントは、卒業予定年の12月末日分までのため、卒業予定の年部分のみを入力'),
                    miniInfo(passText: '例：2020年3月に卒業式を行い卒業する場合は「2020年」を選択', customIcon: Icons.tips_and_updates_outlined),
                  ],),
                  toggleFieldInput: Container(
                    child: compInputDialogSelectType(
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
                  ),
                ),
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
