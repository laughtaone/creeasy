import 'package:flutter/material.dart';
import 'package:creeasy/common_comp.dart';

class ChangeBankPage extends StatefulWidget {
  // final String? selectedCardName;
  // const ChangeBankPage({Key? key, required this.selectedCardName}): super(key: key);

  @override
  _ChangeBankPageState createState() => _ChangeBankPageState();
}


class _ChangeBankPageState extends State<ChangeBankPage> {
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
              Icons.assured_workload_outlined,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              '銀行情報を変更',
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
                // =============================================== ⓪ 選択されたカード名 ==============================================
                SizedBox(height: 5),
                Container(
                  padding:
                      EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfff8f8f8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleTextComp(
                          resvIcon: Icons.credit_card_outlined,
                          resvText: '選択されたカード名'),
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        height: 30,
                        child: Text(
                          '未選択',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                // =======================================================================================================
              ],
            ),
        )
      )
    );
  }
}