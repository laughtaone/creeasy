import 'package:flutter/material.dart';

class AddCardPagePresetCard extends StatefulWidget {
  // final String selectedCardName;

  // OptionTextButton({
  //   required this.selectedCardName,
  // });

  @override
  _AddCardPagePresetCardState createState() => _AddCardPagePresetCardState();
}

class _AddCardPagePresetCardState extends State<AddCardPagePresetCard> {

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
      body: Text('プリセットされたカードの微調整'),
    );
  }
}
