import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/add_card/add_card_main.dart';
import 'package:creeasy/card_manage/card_manage_card-tile.dart';
import 'package:creeasy/card_manage/card_manage_bank-tile.dart';
import 'package:creeasy/card_manage/add_bank/add_bank_main.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:creeasy/card_manage/bank_example_icon.dart';
import 'package:creeasy/status/status_fundbox_tile_comp.dart';




class CardManagePage extends StatefulWidget {
  const CardManagePage({super.key});

  @override
  _CardManagePageState createState() => _CardManagePageState();
}

class _CardManagePageState extends State<CardManagePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  IconData _actionIcon = Icons.credit_card;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Tabが変更されたときにインデックスを取得する
    _tabController.addListener(() {
      setState(() {
        switch (_tabController.index) {
          case 0:
            _actionIcon = Icons.credit_card;
            break;
          case 1:
            _actionIcon = Icons.account_balance_outlined;
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wallet_outlined, color: Colors.black),
              SizedBox(width: 5),
              Text(
                'カード関係管理',
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Row(children: [
                const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                Icon(
                  _actionIcon,
                  color: Colors.black,
                ),
              ]),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => (_tabController.index == 0)
                      ? const AddCardPage()
                      : const AddBankPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
            )
          ],
          backgroundColor:
              Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
          bottom: TabBar(controller: _tabController, tabs: const [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.credit_card),
                  SizedBox(width: 5),
                  Text('カード'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_outlined),
                  SizedBox(width: 5),
                  Text('銀行'),
                ],
              ),
            )
          ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // ===================================== カード タブ =========================================
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: ListView(children: [
                miniInfo(
                  passText: '変更がある場合は各カードの枠内をタップして編集',
                  customTextSize: 13, needsTBPadding: true, customTopPadding: 6, customBottomPadding: 10
                ),
                const CardManageCardTile(
                  card_name: '三井住友カードaaaaaaaaaaaaaaa',
                  return_rate_unit: 200,
                  return_rate: 0.5,
                  target_range: '1日-末日',
                  pay_date: '翌月26日',
                  bool_pointup: true
                ),
                const CardManageCardTile(
                  card_name: 'メルカード',
                  return_rate_unit: 100,
                  return_rate: 1,
                  target_range: '1日-末日',
                  pay_date: '自由',
                  bool_pointup: false
                ),
              ]),
            ),
            // =======================================================================================

            // ===================================== 銀行 タブ =========================================
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: ListView(
                children: [
                  miniInfo(
                    passText: '編集するには各銀行の枠内をタップ',
                    customTextSize: 16, customPlacement: 'center', needsTBPadding: true, customTopPadding: 6, customBottomPadding: 10
                  ),

                  bankExampleIcon(),   // 通常口座・口座内ボックス アイコン 凡例

                  const CardManageBankTile(recvBankName: 'みんなの銀行 - 専用ボックスああああああああああああああああああああああああああああああああ', recvBankType: 1),
                  const CardManageBankTile(recvBankName: '三井住友銀行'),
                  const CardManageBankTile(recvBankName: '三菱UFJ銀行'),
                ],
              ),
            ),
            // =======================================================================================

          ],
        ),
      ),
    );
  }
}
