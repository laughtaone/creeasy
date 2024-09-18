import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/appbar/common_appbar_comp.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:creeasy/money_manage/pay_history_tile_comp.dart';



class MoneyManagePage extends StatefulWidget {
  const MoneyManagePage({super.key});

  @override
  _MoneyManagePageState createState() => _MoneyManagePageState();
}


class _MoneyManagePageState extends State<MoneyManagePage> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> _payHistories = [
    {'payDate': DateTime(2024, 9, 5), 'payPlace': 'セブン', 'payCardName': '三井住友カード', 'connectBank': '三菱UFJ銀行', 'payPrice': 392, 'isSetureMoney': true},
    {'payDate': DateTime(2024, 9, 12), 'payPlace': 'Suicaチャージ', 'payCardName': 'ビックSuicaカード', 'connectBank': 'ゆうちょ銀行', 'payPrice': 1000, 'isSetureMoney': false},
    {'payDate': DateTime(2024, 9, 12), 'payPlace': 'Suicaチャージ', 'payCardName': 'ビックSuicaカード', 'connectBank': 'ゆうちょ銀行', 'payPrice': 10000, 'isSetureMoney': false},
    {'payDate': DateTime(2024, 9, 12), 'payPlace': 'Suicaチャージ', 'payCardName': 'ビックSuicaカードビックSuicaカード', 'connectBank': 'ゆうちょ銀行', 'payPrice': 100000, 'isSetureMoney': false},
    {'payDate': DateTime(2024, 9, 15), 'payPlace': 'AppleStore', 'payCardName': 'メルカード', 'connectBank': 'ゆうちょ銀行', 'payPrice': 1000000, 'isSetureMoney': false},
  ];


  Color gusuColumnColor = const Color(0xffe0e0e0);
  Color kisuColumnColor = const Color(0xfff3f3f3);


  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // // Tabが変更されたときにインデックスを取得する
    // _tabController.addListener(() {
    //   setState(() {
    //     switch (_tabController.index) {
    //       case 0:
    //         _actionIcon = Icons.credit_card;
    //         break;
    //       case 1:
    //         _actionIcon = Icons.account_balance_outlined;
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: commonAppBarComp(
      //   context: context,
      //   recvIcon: Icons.task_alt_outlined,
      //   recvText: '利用履歴管理'
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.task_alt_outlined, color: Colors.black),
            SizedBox(width: 5),
            Text('利用履歴管理'),
          ],
        ),
        // actions: [
        //   TextButton(
        //     child: Row(children: [
        //       const Icon(
        //         Icons.add,
        //         color: Colors.black,
        //       ),
        //       Icon(
        //         _actionIcon,
        //         color: Colors.black,
        //       ),
        //     ]),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => (_tabController.index == 0)
        //             ? const AddCardPage()
        //             : const AddBankPage(),
        //           fullscreenDialog: true,
        //         ),
        //       );
        //     },
        //   )
        // ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.unpublished_outlined),
                SizedBox(width: 5),
                Text('資金未確保'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outlined),
                SizedBox(width: 5),
                Text('資金確保済'),
              ],
            ),
          )
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView.builder(
              itemCount: _payHistories.length,
              itemBuilder: (context, index) {
                return PayHistoryTileComp(
                  payPlace: _payHistories[index]['payPlace'],
                  payDate: _payHistories[index]['payDate'],
                  payCardName: _payHistories[index]['payCardName'],
                  connectBank: _payHistories[index]['connectBank'],
                  payPrice: _payHistories[index]['payPrice'],
                  isSetureMoney: _payHistories[index]['isSetureMoney'],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:  Text('a')
          )
        ]
      ),
    );
  }
}


class SinglePayHistory {
  final String place;
  final int price;

  SinglePayHistory(this.place, this.price);
}
