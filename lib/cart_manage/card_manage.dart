import 'package:flutter/material.dart';
import 'package:creeasy/main.dart';

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
              Icons.shopping_bag,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black // ライトモードの色
                  : Colors.white, // ダークモードの色
            ),
            SizedBox(width: 5),
            Text(
              '置き勉管理',
            ),
          ],
        ),
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),),
    );
  }
}