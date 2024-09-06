import 'package:flutter/material.dart';
import 'package:creeasy/common_component.dart';

class ChangeCardPage extends StatefulWidget {
  @override
  _ChangeCardPageState createState() => _ChangeCardPageState();
}


class _ChangeCardPageState extends State<ChangeCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.credit_score_outlined,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              'カード情報を変更',
            ),
          ],
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
        actions: [
          // IconButton(
          //   padding: EdgeInsets.only(right: 20),
          //   icon: Icon(Icons.close, size: 27),
          //   onPressed: () {Navigator.of(context).pop();}
          // )
          ToprightCloseButton()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      ),
    );
  }
}