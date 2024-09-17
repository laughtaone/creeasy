import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:flutter/material.dart';
import 'package:creeasy/status/status_bank_tile_comps.dart';


class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  _StatusPageState createState() => _StatusPageState();
}


// class _StatusPageState extends State<StatusPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: commonAppBarComp(
//         context: context,
//         recvIcon: Icons.directions_walk_outlined,
//         recvText: '状況'
//       ),
//       body: const Padding(
//           padding: EdgeInsets.only(left: 20, right: 20, top: 10),),
//     );
//   }
// }


class _StatusPageState extends State<StatusPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> _statusBankList = [['三井住友銀行', 102314], ['三菱UFJ銀行', 9102]];

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.directions_walk_outlined, color: Colors.black),
              SizedBox(width: 5),
              Text('状況'),
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
                  Icon(Icons.account_balance_outlined),
                  SizedBox(width: 5),
                  Text('銀行'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.savings_outlined),
                  SizedBox(width: 5),
                  Text('口座内のボックス'),
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
                miniInfo(passText: '以下の金額は、各口座で想定される必要最低限の残高を示しています', customTextSize: 14, customTopPadding: 7, customBottomPadding: 17),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _statusBankList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StatusBankTileComp(
                      bankName: _statusBankList[index][0],
                      bankBalance: _statusBankList[index][1],
                    );
                  }
                )

              ]),
            ),
            // =======================================================================================

            // ===================================== 銀行 タブ =========================================
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: ListView(
                children: [

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
