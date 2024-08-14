import 'package:flutter/material.dart';
import 'package:creeasy/main.dart';
import 'package:creeasy/home/home_card-tile.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: false,
      //   backgroundColor: Colors.white,
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 0),
      //     child: Text(
      //       'こんにちは',
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         fontSize: 30,
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: ListView(
          children: [
            Text(
              'こんにちは',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.equalizer, size: 25, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  '今月の使用状況',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            HomeCardTile(card_name: '三井住友カード', month_price: 2987),
            HomeCardTile(card_name: 'メルカード', month_price: 7102),
            HomeCardTile(card_name: 'LINEクレカ(P+)', month_price: 10183),
            HomeCardTile(card_name: 'ビューカード', month_price: 36090),
            HomeCardTile(card_name: 'PayPayカード', month_price: 1529),
            HomeCardTile(card_name: '楽天カード', month_price: 5625),
            HomeCardTile(card_name: 'auPAYカード', month_price: 1025),
            HomeCardTile(card_name: 'dカード', month_price: 423),
          ],
        ),
      ),
    );
  }
}