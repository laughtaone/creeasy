import 'package:flutter/material.dart';
import 'package:creeasy/main.dart';
import 'package:creeasy/cart_manage/add_card.dart';
import 'package:creeasy/cart_manage/card_manage_card-tile.dart';



class CardManagePage extends StatefulWidget {
  @override
  _CardManagePageState createState() => _CardManagePageState();
}

class _CardManagePageState extends State<CardManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.credit_card,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              'カード管理',
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
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ListView(
          children: [
            // ==================================== 編集方法の案内 ====================================
            // Container(
            //   padding: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Color(0xffeeeeee),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(Icons.info_outline),
            //       SizedBox(width: 10),
            //       Text('編集するには各カードの枠内をタップ', style: TextStyle(fontWeight: FontWeight.w400),)
            //     ],
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(width: 10),
                  Text('編集するには各カードの枠内をタップ', style: TextStyle(fontWeight: FontWeight.w400),)
                ],
              ),
            ),
            // =======================================================================================


            CardManageCardTile(card_name: '三井住友カード', return_rate: 0.5, target_range: '', pay_date: '',),

          ],
        ),
      ),
    );
  }
}