import 'package:flutter/material.dart';

class AddCardPageDirectInputCard extends StatefulWidget {
  @override
  _AddCardPageDirectInputCardState createState() => _AddCardPageDirectInputCardState();
}

class _AddCardPageDirectInputCardState extends State<AddCardPageDirectInputCard> {

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
              Icons.add_card_outlined,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              'カードを追加',
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ))
        ],
      ),
      body: Text('カード情報を直接入力'),
    );
  }
}
