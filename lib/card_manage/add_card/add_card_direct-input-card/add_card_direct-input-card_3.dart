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
import 'package:creeasy/card_manage/card_manage_COMPS/selected_card_intro_comp.dart';






class AddCardPageDirectInputCard3 extends StatefulWidget {
  const AddCardPageDirectInputCard3({super.key});

  @override
  _AddCardPageDirectInputCard3State createState() =>
      _AddCardPageDirectInputCard3State();
}

class _AddCardPageDirectInputCard3State extends State<AddCardPageDirectInputCard3> {
  // ================================ 変数処理 ================================
  int? _isManageReturnRate;
  double? _inputtedReturnRate;
  int? _isExistPointup;
  int? _isManagePointup;
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
                    // ================================================ 3.管理項目について =================================================
                    // --------------------------- ⓪必須項目 ----------------------------
                    titleTextComp(resvText: 'Step3：管理項目について', hTextType: 1, customBottomMargin: 15),
                    selectTileComp(
                      customBackColor: const Color(0xfff2f2f2),
                      titleComp: titleTextComp(resvText: '必須項目', resvTextSize: 20),
                      fieldInput: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: Column(children: [
                          const Text('次の2つの項目はデフォルトで管理され、この項目を削除することはできません。', style: TextStyle(fontSize: 15)),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              // color: const Color(0xffe8e8e8),
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Align(child: SizedBox(
                              width: 170,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  miniInfo(passText: '使用金額', customIcon: Icons.currency_yen_outlined, customTextSize: 17, isLimitOneline: true),
                                  miniInfo(passText: '口座残高の確保', customIcon: Icons.account_balance_wallet_outlined, customTextSize: 17, isLimitOneline: true),
                                ],
                              ),
                            )),
                          ),
                        ]),
                      )
                    ),
                    // ------------------------------------------------------------------------

                    betweenIcon(Icons.add),

                    // --------------------------- ①基本還元率 ----------------------------
                    selectTileButtonToggleComp(
                      mainTitleComp: titleTextComp(resvIcon: Icons.soap_outlined, resvText: '基本還元ポイントの管理'),
                      mainGuides: Column(children: [miniInfo(
                        passText: '基本還元分のポイントを管理しますか？',
                        needsIcon: false,
                        customTextSize: 15,
                        customTopPadding: 5
                      )]),
                      mainSelectList: const ['しない', 'する'],
                      argMainCallback: (int? resvIndex) {
                        setState(() {
                          _isManageReturnRate = resvIndex;
                        });
                      },
                      nowMainSelectbuttonIndex: _isManageReturnRate,
                      customFontsizeMainSelectButton: 20,
                      customIconsizeMainSelectButton: 28,
                      toggleTitleComp: titleTextComp(resvIcon: Icons.percent_outlined, resvText: '基本還元率を入力'),
                      toggleFieldInput: compInputDoubleType(
                        resvNowInputingDouble: _inputtedReturnRate,
                        suffixText: '%',
                        argCallback: (String? recvReturnRate) {
                          switch (recvReturnRate) {
                            case ''||null:
                              setState(() {
                                _inputtedReturnRate = null;
                              });
                              break;
                            default:
                              setState(() {
                                _inputtedReturnRate = double.parse(recvReturnRate);
                              });
                              break;
                          }
                        },
                      )
                    ),
                    // ------------------------------------------------------------------------

                    betweenIcon(Icons.add),

                    // --------------------------- ボーナスポイント ----------------------------
                    selectTileButtonToggleComp(
                      mainTitleComp: titleTextComp(resvIcon: Icons.switch_access_shortcut_add_outlined, resvText: 'ポイントアップ分の管理'),
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
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('ポイントアップ分のポイントがありますか？', style: TextStyle(fontSize: 16)),
                        ),
                      ]),
                      mainSelectList: const ['ない', 'ある'],
                      argMainCallback: (int? resvIndex) {
                        setState(() {
                          _isExistPointup = resvIndex;
                        });
                      },
                      nowMainSelectbuttonIndex: _isExistPointup,
                      customFontsizeMainSelectButton: 20,
                      customIconsizeMainSelectButton: 28,
                      toggleTitleComp: titleTextComp(resvText: 'ポイントアップ分のポイントまで管理しますか？',),
                      toggleFieldInput: selectTileButtonToggleComp(
                        mainTitleComp: miniInfo(passText: 'ポイントアップ分のポイントまで管理しますか？'),
                        mainSelectList: const ['管理しない', '管理する'],
                        nowMainSelectbuttonIndex: _isManagePointup,
                        argMainCallback: (int? resvIndex) {
                          _isManagePointup = resvIndex;
                        },
                        toggleTitleComp: miniInfo(
                          passText: 'ポイントアップの情報を入力',
                          needsIcon: false,
                          customTextSize: 17,
                        ),
                        toggleFieldInput: Container(
                          child: Text('あああ'),
                        ),
                      ),
                      // toggleFieldInput: compInputDoubleType(
                      //   resvNowInputingDouble: _inputtedReturnRate,
                      //   suffixText: '%',
                      //   argCallback: (String? recvReturnRate) {
                      //     switch (recvReturnRate) {
                      //       case ''||null:
                      //         setState(() {
                      //           _inputtedReturnRate = null;
                      //         });
                      //         break;
                      //       default:
                      //         setState(() {
                      //           _inputtedReturnRate = double.parse(recvReturnRate);
                      //         });
                      //         break;
                      //     }
                      //   },
                      // )
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
                            builder: (context) => const AddCardPageDirectInputCard3(),
                          ),
                        );
                      },
                    ),
                    // ===========================================================================================================

                  ],
                ))));
  }
}
