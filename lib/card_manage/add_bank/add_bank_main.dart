import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_column_direct_select_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_string_type.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/between/between_select_field.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/save_button_comp.dart';




class AddBankPage extends StatefulWidget {
  const AddBankPage({super.key});

  @override
  _AddBankPageState createState() => _AddBankPageState();
}

class _AddBankPageState extends State<AddBankPage> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _bankTypeList = [
    '通常口座',
    '口座内のボックス',
  ];

  // ================================ 変数処理 ================================
  String? _inputBankName; // ①で入力された銀行名を保持する変数
  int? _selectedBankType; // ②で選択された銀行タイプ
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
              Icon(Icons.account_balance_outlined, color: Colors.black),
              SizedBox(width: 5),
              Text(
                '銀行を追加',
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
                  // =============================================== ①銀行名 ==============================================
                  betweenSelectField(),
                  selectTileComp(
                    titleComp: titleTextComp(resvIcon: Icons.account_balance_outlined, resvText:'銀行名を入力'),
                    fieldInput: Container(child: compInputStringType(
                      resvNowInputingString: _inputBankName,
                      argCallback: (recvString) {
                        // コールバックを渡す
                        setState(() {
                          _inputBankName = recvString; // コールバックで受け取った値を保持
                        });
                      },
                    ))
                  ),
                  // =======================================================================================================

                  // =============================================== ②銀行タイプ ==============================================
                  betweenSelectField(),
                  selectTileComp(
                    titleComp: titleTextComp(resvIcon: Icons.local_offer_outlined, resvText:'銀行のタイプを選択'),
                    guides: Column(children: [
                      miniInfo(passText: '通常口座は、一般的なただの銀行の口座を指します'),
                      miniInfo(needsIcon: false, passText: '（例：三井住友銀行 普通口座 ??支店 XXXXXXX）'),
                      const SizedBox(height: 5),
                      miniInfo(passText: '口座内のボックスは、口座内でさらに分けて管理\nできる貯蓄ボックスを指します'),
                      miniInfo(needsIcon: false, passText: '（例：みんなの銀行 貯蓄預金「ボックス」）'),
                    ],),
                    fieldInput: CompInputColumnDirectSelectType(
                      elementsList: _bankTypeList,
                      customIconSize: 29,
                      resvNowSelectingIndex: _selectedBankType,
                      argCallback: (int? recvIndex) {
                        setState(() {
                          _selectedBankType = recvIndex;
                        });
                      },
                    )
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
              ),
            )));
  }
}
