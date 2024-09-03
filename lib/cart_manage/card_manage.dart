import 'package:flutter/material.dart';
import 'package:creeasy/main.dart';
import 'package:creeasy/cart_manage/add_card/add_card_main.dart';
import 'package:creeasy/cart_manage/card_manage_card-tile.dart';
import 'package:creeasy/cart_manage/card_manage_bank-tile.dart';




class CardManagePage extends StatefulWidget {
  @override
  _CardManagePageState createState() => _CardManagePageState();
}

class _CardManagePageState extends State<CardManagePage> {
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
              Icon(
                Icons.fact_check_outlined,
                color: Colors.black
              ),
              SizedBox(width: 5),
              Text(
                'カード関係管理',
              ),
            ],
          ),
          actions: [IconButton(
            icon: Icon(Icons.add, color: Colors.black,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCardPage(),
                  fullscreenDialog: true,
                ),
              );
            },
          )],
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
          bottom: const TabBar(
            tabs: [
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
            ]
          ),
        ),
        body: TabBarView(
          children: [
            // ===================================== カード タブ =========================================
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
                        Text('編集するには各カードの枠内をタップ', style: TextStyle(fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ),
                  CardManageCardTile(card_name: '三井住友カード', return_rate_unit: 200, return_rate: 0.5, target_range: '1日-末日', pay_date: '翌月26日', bool_pointup: true),
                  CardManageCardTile(card_name: 'メルカード', return_rate_unit: 100, return_rate: 1, target_range: '1日-末日', pay_date: '自由', bool_pointup: false),
                ]
              ),
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
                        Text('編集するには各銀行の枠内をタップ', style: TextStyle(fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ),
                  CardManageBankTile(bank_name: 'みんなの銀行 - 専用ボックス'),
                  CardManageBankTile(bank_name: '三井住友銀行',),
                  CardManageBankTile(bank_name: '三菱UFJ銀行',),
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