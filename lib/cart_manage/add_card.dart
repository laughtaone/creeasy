import 'package:flutter/material.dart';

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
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
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
        child: ListView(
          children: [
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
