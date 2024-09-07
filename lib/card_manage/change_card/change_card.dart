import 'package:flutter/material.dart';
import 'package:creeasy/common_comp.dart';
import 'package:creeasy/card_manage/card_manage_comp.dart';


class ChangeCardPage extends StatefulWidget {
  final String? selectedCardName;
  const ChangeCardPage({Key? key, required this.selectedCardName}): super(key: key);

  @override
  _ChangeCardPageState createState() => _ChangeCardPageState();
}


class _ChangeCardPageState extends State<ChangeCardPage> {
  final List<String> _bankList = ['三菱UFJ銀行', 'みんなの銀行', '三井住友銀行'];

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
              Icons.credit_score_outlined,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              'カード情報を変更',
            ),
          ],
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
        actions: [ToprightCloseButton()],
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
            child: ListView(
              children: [
                // ========================================================== ⓪ 選択されたカード名 ==========================================================
                SizedBox(height: 5),
                selectedCardIntro(widget.selectedCardName),
                // =======================================================================================================================================

                betweenIcon(Icons.arrow_downward_outlined),

                // ============================================================= ⓪ 注意書き =============================================================
                cautionComp(
                  Column(
                    children: [
                      miniInfo(customIcon: Icons.error_outline_outlined, passText: '表示されている項目のみが変更可能です', customTextSize: 14),
                      miniInfo(passText: '以下の項目は変更できません：', customTextSize: 14),
                      miniInfo(needsIcon: false, doukaColor: Color(0xffffffe7), passText: '・締日/引き落とし日'),
                      miniInfo(needsIcon: false, doukaColor: Color(0xffffffe7), passText: '・基本還元率'),
                    ],
                  )
                ),
                // =======================================================================================================================================

                SizedBox(height: 12),
                titleTextComp(resvText: 'カード情報を編集', resvTextSize: 20),
                SizedBox(height: 12),

                // =========================================================== ① 引き落とし口座を選択 ===========================================================
                PayBankComp(resvNowSelectingBankIndex: 0, bankList: _bankList)
                // =======================================================================================================================================





              ],
            ),
        )
      )
    );
  }
}