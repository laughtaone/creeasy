import 'package:flutter/material.dart';
import 'package:creeasy/5tabs/home/home_card-tile.dart';
import 'package:creeasy/5tabs/home/settings/settings.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'こんにちは',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.settings, size: 27),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            const Row(
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
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(6),
              child: const Text('全カード合計金額：¥54,289', style: TextStyle(fontSize: 22),)
            ),
            const SizedBox(height: 10),
            const HomeCardTile(card_name: '三井住友カード', month_price: 2987),
            const HomeCardTile(card_name: 'メルカード', month_price: 7102),
            const HomeCardTile(card_name: 'LINEクレカ(P+)', month_price: 10183),
            const HomeCardTile(card_name: 'ビューカード', month_price: 36090),
            const HomeCardTile(card_name: 'PayPayカード', month_price: 1529),
            const HomeCardTile(card_name: '楽天カード', month_price: 5625),
            const HomeCardTile(card_name: 'auPAYカード', month_price: 1025),
            const HomeCardTile(card_name: 'dカード', month_price: 423),
          ],
        ),
      ),
    );
  }
}