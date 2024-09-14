import 'package:creeasy/COMMON_COMPS/between/between_icon.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/add_card/add_card_preset-card.dart';
import 'package:creeasy/card_manage/add_card/add_card_direct-input-card/add_card_direct-input-card_1.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/made_comp/next_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/made_comp/chokusetsunyuuryou_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/no_save_close_comp.dart';
import 'package:auto_size_text/auto_size_text.dart';




class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _presetCardBrandList = [
    '三井住友カード',
    'メルカリ',
    'ビューカード',
    'PayPay',
    'LINE',
    'エポス',
    'auPAY',
    'dカード',
  ];
  final List<List<String>> _presetCardList = [
    ['三井住友カード(NL)', '三井住友カード(CL)', '三井住友カード ゴールド(NL)'],
    ['メルカード'],
    ['JREカード', 'ビックSuicaカード'],
    ['PayPayカード', 'PayPayカード ゴールド'],
    ['LINEクレカ', 'LINEクレカ(P+)'],
    ['エポスカードVisa', 'エポスゴールドカード'],
    ['auPAYカード', 'auPAYゴールドカード'],
    ['dカード', 'dカードゴールド'],
  ];




  // ================================ 変数処理 ================================
  String? _selectedItem; // ①で選択されたカードを保持する変数
  int? _selectedCardBrandIndex;
  int? _selectedCardIndex;  // 選択されたカード


  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                Navigator.pop(context);
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
              // ========================================== ①支払いカード選択 ==========================================
              const SizedBox(height: 10),
              const Text(
                r'\\まずはプリセットに用意されているかチェック//',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 5),
              selectTileComp(
                titleComp: titleText(Icons.credit_card_outlined, '追加するカードを選択'),
                guides: Column(children: [
                  miniInfo(passText: 'プリセットされているカードは、管理できる項目がそのカードに特化しているため、非常に管理がしやすいメリットがあります')
                ]),
                fieldInput: Container(
                  margin: const EdgeInsets.only(top: 3),
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffd5d5d5),
                  ),
                  child: Column(
                    children: [
                      titleTextComp(resvIcon: Icons.search, resvText: 'カードを探す', customFontWeight: FontWeight.w700),
                      Align(alignment: Alignment.centerRight, child: Text(_selectedCardBrandIndex.toString())),
                      // -------------------------------------- ブランド --------------------------------------
                      selectTileComp(
                        // customBackColor: const Color(0xffe3e3e3),
                        customBackColor: const Color(0xffd5d5d5),
                        customTBPadding: const [5, 5],
                        titleComp: titleTextComp(resvIcon: Icons.local_offer_outlined, resvText: 'ブランドを選択', customIconSize: 20, customBetweenIT: 3),
                        fieldInput: compInputDialogSelectType(
                          customTBPadding: 0,
                          customTBMargin: const [5, 3],
                          customMainTextSize: 17,
                          elementsList: _presetCardBrandList,
                          resvNowSelectingIndex: _selectedCardBrandIndex,
                          dialogText: 'ブランド一覧：',
                          argCallback: (int? resvIndex) {
                            _selectedCardBrandIndex = resvIndex;
                            _selectedCardIndex = null;
                            setState(() {
                              _selectedCardIndex = null;
                              _selectedCardBrandIndex = resvIndex;
                            });
                          },
                        ),
                      ),
                      // ------------------------------------------------------------------------------------

                      betweenIcon(recvIcon: Icons.arrow_downward, customTBPadding: [10, 10]),

                      Align(alignment: Alignment.centerRight, child: Text(_selectedCardIndex.toString())),
                      // ---------------------------------- 追加するカードを表示 ----------------------------------
                      selectTileComp(
                        customBackColor: const Color(0xffd5d5d5),
                        customTBPadding: const [5, 5],
                        titleComp: titleTextComp(resvText: '追加するカード'),
                        fieldInput: compInputDialogSelectType(
                          customTBPadding: 0,
                          customTBMargin: const [5, 3],
                          customMainTextSize: 17,
                          canTapField: (_selectedCardBrandIndex!=null),
                          elementsList: (_selectedCardBrandIndex!=null) ?_presetCardList[_selectedCardBrandIndex!]: [''*_presetCardBrandList.length],
                          resvNowSelectingIndex: _selectedCardIndex,
                          dialogText: 'ブランド一覧：',
                          argCallback: (int? resvIndex) {
                            _selectedCardIndex = resvIndex;
                            setState(() {
                              _selectedCardIndex = resvIndex;
                            });
                          },
                        ),
                      ),
                      // ------------------------------------------------------------------------------------
                    ],
                  ),
                ),
              ),
              // ====================================================================================================

              const SizedBox(height: 20),

              // =============================================== 「次へ」ボタン ==============================================
              NextButtonComp(
                isCanPressNextButton: (_selectedCardIndex!=null) ?true :false,
                argOnpressed: () {
                  (_selectedCardIndex!=null)
                  ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCardPagePresetCard(selectedCardName: _selectedItem),
                    ),
                  )
                  : null
                  ;
                },
              ),
              // =======================================================================================================

              const SizedBox(height: 16),

              // =============================================== 「直接入力」ボタン ==============================================
              ChokusetsuNyuuryokuButtonComp(
                // _isCanPressNextButton
                argOnpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCardPageDirectInputCard1(),
                    ),
                  );
                },
              ),
              // =======================================================================================================

              noSaveCloseComp(messageType: 0),
            ],
          ),
        )
      )
    );
  }
}

// タイトルコンポーネント(このページ内のみで使用)
Row titleText(IconData receivedIcon, String originalText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(width: 2),
      Icon(
        receivedIcon,
        size: 23,
      ),
      const SizedBox(width: 5),
      Text(
        originalText,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    ],
  );
}
