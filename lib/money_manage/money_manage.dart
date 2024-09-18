import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/appbar/common_appbar_comp.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:auto_size_text/auto_size_text.dart';



class MoneyManagePage extends StatefulWidget {
  const MoneyManagePage({super.key});

  @override
  _MoneyManagePageState createState() => _MoneyManagePageState();
}


class _MoneyManagePageState extends State<MoneyManagePage> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> _payHistories = [
    {'day': '9/5', 'place': 'セブン', 'cardName': '三井住友カード', 'price': 392, 'isKeepMoney': true},
    {'day': '9/11', 'place': 'Suicaチャージ', 'cardName': 'ビックSuicaカード', 'price': 1000, 'isKeepMoney': false},
    {'day': '12/25', 'place': 'Suicaチャージ', 'cardName': 'ビックSuicaカード', 'price': 1000, 'isKeepMoney': false},
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TabBarView(
            controller: _tabController,
            children: [
              // ===================================== 資金未確保タブ =========================================
              Container(
                width: double.infinity,
                child: DataTable(
                  columnSpacing: 0,
                  horizontalMargin: 0,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Container(
                          width: 45,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('利用日'),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Container(
                          width: 75,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('利用場所'),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Container(
                          width: 75,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('利用カード'),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Container(
                          width: 45,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('利用額'),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Container(
                          width: 45,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('💰済？'),
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: _payHistories.map((singlePayHistory) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Container(
                            width: 45,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                singlePayHistory['day'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 75,
                            child: AutoSizeText(
                              singlePayHistory['place'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              minFontSize: 10,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 75,
                            child: AutoSizeText(
                              singlePayHistory['cardName'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              minFontSize: 10,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 45,
                            child: Text(
                              singlePayHistory['price'].toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                              width: 45,
                              child: Text(
                                singlePayHistory['isKeepMoney'] ? '済' : '未',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              // =======================================================================================
        
              // ================================== 資金ボックスタブ ======================================
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: ListView(children: [
                ]),
              ),
              // =======================================================================================
        
            ],
          ),
      ),
      );
  }
}


class SinglePayHistory {
  final String place;
  final int price;

  SinglePayHistory(this.place, this.price);
}
