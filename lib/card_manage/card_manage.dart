import 'package:creeasy/common_component.dart';
import 'package:flutter/material.dart';
import 'package:creeasy/main.dart';
import 'package:creeasy/card_manage/add_card/add_card_main.dart';
import 'package:creeasy/card_manage/card_manage_card-tile.dart';
import 'package:creeasy/card_manage/card_manage_bank-tile.dart';
import 'package:creeasy/card_manage/add_bank/add_bank_main.dart';
import 'package:creeasy/card_manage/change_card/change_card.dart';

class CardManagePage extends StatefulWidget {
  @override
  _CardManagePageState createState() => _CardManagePageState();
}

class _CardManagePageState extends State<CardManagePage>
  with SingleTickerProviderStateMixin {
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
          title: Row(
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
                Icon(
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
                      ? AddCardPage()
                      : AddBankPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
            )
          ],
          backgroundColor:
              Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
          bottom: TabBar(controller: _tabController, tabs: [
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
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 10),
                  child: miniInfo(passText: '変更がある場合は各カードの枠内をタップして編集', customTextSize: 13, ),
                ),
                CardManageCardTile(
                    card_name: '三井住友カード',
                    return_rate_unit: 200,
                    return_rate: 0.5,
                    target_range: '1日-末日',
                    pay_date: '翌月26日',
                    bool_pointup: true),
                CardManageCardTile(
                    card_name: 'メルカード',
                    return_rate_unit: 100,
                    return_rate: 1,
                    target_range: '1日-末日',
                    pay_date: '自由',
                    bool_pointup: false),
              ]),
            ),
            // =======================================================================================

            // ===================================== 銀行 タブ =========================================
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline),
                        SizedBox(width: 6),
                        Text(
                          '編集するには各銀行の枠内をタップ',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  CardManageBankTile(bank_name: 'みんなの銀行 - 専用ボックス'),
                  CardManageBankTile(
                    bank_name: '三井住友銀行',
                  ),
                  CardManageBankTile(
                    bank_name: '三菱UFJ銀行',
                  ),
                ],
              ),
            )
            // =======================================================================================
          ],
        ),
      ),
    );
  }
}
