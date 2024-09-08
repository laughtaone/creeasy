import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/between/between_select_field.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_int_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_date_type.dart';
import 'package:creeasy/COMMON_COMPS/buttons/save_button_comp.dart';



class AddUsePointPage extends StatefulWidget {
  @override
  _AddUsePointPageState createState() => _AddUsePointPageState();
}


class _AddUsePointPageState extends State<AddUsePointPage> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _items = [
    '三井住友カード',
    'メルカード',
    'ビューカード',
    'PayPayカード',
    'LINEクレカ(P+)',
    'エポスカード'
  ];

  // ================================ 変数処理 ================================
  int? selectedCardIndex; // ①で選択されたカードのインデックス番号を保持する変数
  String? inputUsePoint = ''; // ②で入力された金額を保持する変数
  DateTime? _specialUsePointDate; // ③で入力された日付を保持する変数
  // =========================================================================




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.stars_outlined,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              'ポイント割当を追加',
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ))
        ],
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
          child: ListView(
            children: [
              // ========================================== ①該当カード選択 ==========================================
              const SizedBox(height: 5),
              selectTileComp(
                titleComp: titleTextComp(resvIcon: Icons.credit_card_outlined, resvText: '該当カードを選択'),
                fieldInput: Container(
                  child: compInputDialogSelectType(
                    elementsList: _items,
                    dialogText: '該当カードを選択：',
                    returnSelectIndex: selectedCardIndex,
                    argCallback: (index) {
                      setState(() {
                        selectedCardIndex = index;
                      });
                    },
                  ),
                ),
              ),
              // ====================================================================================================

              // ========================================== ②割当ポイント数 ==========================================
              betweenSelectField(),
              selectTileComp(
                titleComp: titleTextComp(
                    resvIcon: Icons.stars_outlined, resvText: '割当ポイント数を入力'),
                fieldInput: Container(
                  child: compInputIntType(
                    suffixText: 'P',
                    argCallback: (value) {
                      // コールバックを渡す
                      setState(() {
                        inputUsePoint = value;
                      });
                    },
                  )
                ),
              ),
              // ====================================================================================================

              // =============================================== ③割当日 ==============================================
              betweenSelectField(),
              selectTileComp(
                titleComp: titleTextComp(
                    resvIcon: Icons.event_outlined, resvText: '割当日を入力'),
                fieldInput: Container(
                  child: compInputDateType(
                    dialogText: '割り当て日を選択',
                    resvNowInputingDate: _specialUsePointDate,
                    argCallback: (date) {
                      setState(() {
                        _specialUsePointDate = date;
                      });
                    },
                  ),
                )
              ),
              // ====================================================================================================

              // =============================================== 保存ボタン ==============================================
              SaveButtonComp(
                onSave: () {
                  print('保存されました');
                },
                isCanOnpress: true,
              ),
              // =======================================================================================================

            ],
          )
        ),
      )
    );
  }
}