import 'package:flutter/material.dart';
import 'package:creeasy/components/display_parts/title_text_comp.dart';
import 'package:creeasy/components/buttons/topright_close_button.dart';

class ChangeBankPage extends StatefulWidget {
  final String? selectedBankName;
  // const ChangeBankPage({Key? key, required this.selectedCardName}): super(key: key);

  const ChangeBankPage({super.key, 
    required this.selectedBankName
  });

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
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.assured_workload_outlined, color: Colors.black),
              SizedBox(width: 5),
              Text(
                '銀行情報を変更',
              ),
            ],
          ),
          backgroundColor:
              Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
          actions: const [ToprightCloseButton()],
        ),
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
              child: ListView(
                children: [
                  // =============================================== ⓪ 選択されたカード名 ==============================================
                  const SizedBox(height: 5),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xfff8f8f8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        titleTextComp(resvIcon: Icons.account_balance_outlined, resvText: '選択された銀行名'),
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          height: 30,
                          child: Text(
                            widget.selectedBankName ?? '未選択',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // =======================================================================================================
                ],
              ),
            )));
  }
}
