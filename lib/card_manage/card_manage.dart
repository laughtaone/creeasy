import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/add_card/add_card_main.dart';
import 'package:creeasy/card_manage/card_manage_card-tile.dart';
import 'package:creeasy/card_manage/card_manage_bank-tile.dart';
import 'package:creeasy/card_manage/add_bank/add_bank_main.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:creeasy/card_manage/bank_example_icon.dart';




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
                miniInfo(
                  passText: '変更がある場合は各カードの枠内をタップして編集',
                  customTextSize: 13, needsTBPadding: true, customTopPadding: 6, customBottomPadding: 10
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
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: MediaQuery.of(context).size.height * 0.04,
                  //   child: miniInfo(passText: '編集するには各銀行の枠内をタップ'),
                  // ),
                  // Row(
                  //   children: [
                  //     Flexible(flex: 3, child: miniInfo(passText: '編集するには各銀行の枠内をタップ')),
                  //     Flexible(flex: 1, child: BankExampleIcon())
                  //   ],
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 6, bottom: 4),
                  //   child: miniInfo(
                  //     passText: '編集するには各銀行の枠内をタップ',
                  //     customTextSize: 14,
                  //     customPlacement: 'center'
                  //   ),
                  // ),
                  miniInfo(
                    passText: '編集するには各銀行の枠内をタップ',
                    customTextSize: 14, customPlacement: 'center', needsTBPadding: true, customTopPadding: 6, customBottomPadding: 10
                  ),

                  Align(  // AlignでContainerの幅を制約
                    alignment: Alignment.centerRight, // 左寄せ（必要に応じてcenterなどに変更可能）
                    child: Container(
                      padding: EdgeInsets.fromLTRB(9, 2, 3, 2),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.black, // 色
                        //   width: 1, // 太さ
                        // ),
                        color: Color(0xfff1f1f1),
                        borderRadius: BorderRadius.circular(7)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text('【アイコン】', style: TextStyle(fontSize: 10),),
                          SizedBox(
                            width: 75,  // 固定の幅
                            child: miniInfo(
                              passText: '通常口座',
                              customTextSize: 12,
                              customIcon: Icons.account_balance_outlined,
                              needsLRPadding: false,
                              customIconTextPadding: 1
                            ),
                          ),
                          SizedBox(width: 5),
                          SizedBox(
                            width: 126,  // 固定の幅
                            child: miniInfo(
                              passText: '口座内のボックス',
                              customTextSize: 12,
                              customIcon: Icons.savings_outlined,
                              needsLRPadding: false,
                              customIconTextPadding: 1
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CardManageBankTile(recvBankName: 'みんなの銀行 - 専用ボックスああああああああああああああああああああああああああああああああ', recvBankType: 1),
                  CardManageBankTile(recvBankName: '三井住友銀行'),
                  CardManageBankTile(recvBankName: '三菱UFJ銀行'),
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
