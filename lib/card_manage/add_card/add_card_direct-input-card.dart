import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/save_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_button_toggle_comp.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info_end_page_jump.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info_end_url_jump.dart';
import 'package:creeasy/card_manage/card_manage_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_double_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_string_type.dart';
import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/between/between_select_field.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/between/between_icon.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_row_direct_select_type.dart';





class AddCardPageDirectInputCard extends StatefulWidget {
  const AddCardPageDirectInputCard({super.key});

  @override
  _AddCardPageDirectInputCardState createState() =>
      _AddCardPageDirectInputCardState();
}

class _AddCardPageDirectInputCardState
    extends State<AddCardPageDirectInputCard> {
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

  final List<String> _isPointUp = ['なし', 'あり'];

  // ================================ 変数処理 ================================
  String? _inputCardName;
  String? _inputReturnRate;
  int? _isSpecialPayment;
  int? _closingDate; // ③で入力された締め日を保持する変数
  int? _payDate; // ④で入力された引き落とし日を保持する変数
  int? _selectedBank; // ⑤で選択された銀行を保持する変数
  int? _selectedPointUpIndex;   // ⑥で選択されたポイントアップの有無を保持する変数


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
                    // ==================================================== 1.基本項目 ====================================================
                    titleTextComp(resvText: '基本項目', hTextType: 1),
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
                    // ==================================================================================================================


                    betweenIcon(Icons.add),


                    // ================================================ 2.支払い額について =================================================
                    titleTextComp(resvText: '支払い額について', hTextType: 1),
                    // --------------------------- ①臨時支払いの有無 ----------------------------
                    selectTileComp(
                      titleComp: titleTextComp(resvIcon: Icons.published_with_changes_outlined, resvText: '繰り上げ返済の有無'),
                      fieldInput: CompInputRowDirectSelectType(
                        elementsList: const ['ない', 'ある'],
                        argCallback: (int resvIndex) {
                          setState(() {
                            _isSpecialPayment = resvIndex;
                          });
                        },
                      ),
                    ),
                    // ------------------------------------------------------------------------
                    // --------------------------- ②ポイント割当の有無 ----------------------------
                    betweenSelectField(),
                    selectTileComp(
                      titleComp: titleTextComp(resvIcon: Icons.shopping_cart_checkout_outlined, resvText: 'ポイント割当の有無'),
                      guides: Column(
                        children: [
                          miniInfoEndUrlJump(passText: '繰り上げ返済とは、利用額を引き落とし日よりも前に支払うことです。詳しくは', passUrl: 'https://www.jcb.co.jp/ordercard/special/prepayment.html',)
                        ],
                      ),
                      fieldInput: CompInputRowDirectSelectType(
                        elementsList: const ['ない', 'ある'],
                        argCallback: (int resvIndex) {
                          setState(() {
                            _isSpecialPayment = resvIndex;
                          });
                        },
                      ),
                    ),
                    // ------------------------------------------------------------------------
                    // ==================================================================================================================










                    const SizedBox(height: 500),
                    // =============================================== ①カード名 ==============================================
                    betweenSelectField(),
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
                    // =======================================================================================================

                    // =============================================== ②通常還元率 ==============================================
                    betweenSelectField(),
                    selectTileComp(
                      titleComp: titleTextComp(resvIcon: Icons.percent_outlined, resvText: '基本還元率を入力'),
                      fieldInput: Container(child: compInputDoubleType(
                      suffixText: '%',
                      resvNowInputingDouble: (_inputReturnRate != null) ? double.tryParse(_inputReturnRate!) : null,
                      argCallback: (String? recvString) {
                        setState(() {
                          _inputReturnRate = recvString;
                        });
                      },
                      ),)
                    ),
                    // =======================================================================================================

                    // ========================================== ③締め日 ==========================================
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
                    // ====================================================================================================

                    // ========================================== ④引き落とし日 ==========================================
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
                    // ====================================================================================================

                    // ========================================== ⑤引き落とし口座 ==========================================
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

                    // =============================================== ⑥ポイントアップの選択 ==============================================
                    betweenSelectField(),
                    selectTileButtonToggleComp(
                      mainTitleComp: titleTextComp(resvIcon: Icons.local_offer_outlined, resvText: 'ポイントアップの有無'),
                      mainGuides: Column(children: [
                          miniInfo(passText: '「ポイントアップ」とは特定の店や日付での利用でポイントが上乗せされることを指します'),
                          miniInfo(
                            passText: '例：三井住友カードは「ポイントアッププログラム」があるので「あり」を選択 *1',
                            needsTBPadding: false,
                            customIcon: Icons.tips_and_updates_outlined
                          ),
                          miniInfo(
                            passText: '例：Paidyカードはポイントアップがないので「ない」を選択  *1',
                            needsTBPadding: false,
                            customIcon: Icons.tips_and_updates_outlined
                          ),
                          miniInfo(
                            passText: '*1 2024年9月5日調べ・各カードを批判/優遇/宣伝する意図は無くあくまで例として列挙',
                            customTextSize: 9,
                            needsIcon: false,
                            customColor: Colors.black54
                          ),
                      ]),
                      argMainCallback: (int? recvIndex) {
                        setState(() {
                          _selectedPointUpIndex = recvIndex;
                        });
                      },
                      nowMainSelectbuttonIndex: _selectedPointUpIndex,
                      mainSelectList: _isPointUp,
                      toggleFieldInput: Container(),
                      customFontsizeMainSelectButton: 20,
                      customIconsizeMainSelectButton: 28
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
                  ],
                ))));
  }
}
