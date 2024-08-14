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
              Icons.credit_card,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              'カード管理',
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