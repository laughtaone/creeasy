import 'package:flutter/material.dart';
import 'package:creeasy/add/add_common_component.dart';

class AddCardPageDirectInputCard extends StatefulWidget {
  @override
  _AddCardPageDirectInputCardState createState() =>
      _AddCardPageDirectInputCardState();
}

class _AddCardPageDirectInputCardState
    extends State<AddCardPageDirectInputCard> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _dayList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '末日'
  ];

  final List<String> _bankList = [
    '三菱UFJ銀行',
    'みんなの銀行',
    '三井住友銀行'
  ];

  // ================================ 変数処理 ================================
  final TextEditingController _storeName =
      TextEditingController(); // ①で入力されたカード名を保持する変数
  final TextEditingController _inputReturnRate =
      TextEditingController(); // ②で入力された還元率[%]を保持する変数
  String? _closingDate; // ③で入力された締め日を保持する変数
  String? _payDate; // ④で入力された引き落とし日を保持する変数
  String? _selectedBank; // ⑤で選択された銀行を保持する変数
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_card_outlined, color: Colors.black),
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
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
                padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
                child: ListView(
                  children: [
                    // =============================================== ①カード名 ==============================================
                    betweenAddPaymentSection(),
                    Container(
                      padding: EdgeInsets.only(
                          left: 9, right: 9, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffededed),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addButtonPageTitleText(
                              Icons.credit_card_outlined, 'カード名を入力'),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 70,
                            child: TextField(
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                              ),
                              controller: _storeName,
                              decoration: InputDecoration(
                                labelText: '',
                                contentPadding: EdgeInsets.all(30),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fillColor: Color(0xfffefefe),
                                filled: true,
                              ),
                              keyboardType: TextInputType.text,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly,
                              // ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // =======================================================================================================

                    // =============================================== ②還元率 ==============================================
                    betweenAddPaymentSection(),
                    Container(
                      padding: EdgeInsets.only(
                          left: 9, right: 9, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffededed),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addButtonPageTitleText(
                              Icons.percent_outlined, '還元率を入力'),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 70,
                            child: TextField(
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                              ),
                              controller: _inputReturnRate,
                              decoration: InputDecoration(
                                labelText: '',
                                contentPadding: EdgeInsets.all(30),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixText: '%',
                                fillColor: Color(0xfffefefe),
                                filled: true,
                              ),
                              keyboardType: TextInputType.text,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly,
                              // ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // =======================================================================================================

                    // ========================================== ③締め日 ==========================================
                    betweenAddPaymentSection(),
                    Container(
                      padding: EdgeInsets.only(
                          left: 9, right: 9, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffededed),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addButtonPageTitleText(
                              Icons.credit_card_outlined, '締め日を入力'),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fixedSize: Size(double.infinity, 70),
                                backgroundColor: Color(0xfffefefe),
                              ),
                              child: ListTile(
                                title: Text(
                                    '${_closingDate != null ? (_closingDate != '末日' ? '${_closingDate} 日' : _closingDate) : '未選択'}',
                                    style: TextStyle(fontSize: 20)),
                                trailing: Icon(Icons.edit),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('締め日を選択：'),
                                      backgroundColor: Color(0xffffffff),
                                      content: Container(
                                        width: double.maxFinite,
                                        height: 300,
                                        decoration: BoxDecoration(
                                          // color: Color(0xffdddddd),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Scrollbar(
                                            thumbVisibility: true,
                                            thickness: 2,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: _dayList.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 5,
                                                      bottom: 5,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Color(0xffeeeeee),
                                                  ),
                                                  child: ListTile(
                                                    title: Text(_dayList[index],
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                    onTap: () {
                                                      setState(() {
                                                        _closingDate =
                                                            _dayList[index];
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'キャンセル',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ====================================================================================================

                    // ========================================== ④引き落とし日 ==========================================
                    betweenAddPaymentSection(),
                    Container(
                      padding: EdgeInsets.only(
                          left: 9, right: 9, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffededed),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addButtonPageTitleText(
                              Icons.credit_card_outlined, '引き落とし日を入力'),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fixedSize: Size(double.infinity, 70),
                                backgroundColor: Color(0xfffefefe),
                              ),
                              child: ListTile(
                                title: Text(
                                    '${_payDate != null ? (_payDate != '末日' ? '${_payDate} 日' : _payDate) : '未選択'}',
                                    style: TextStyle(fontSize: 20)),
                                trailing: Icon(Icons.edit),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('引き落とし日を選択：'),
                                      backgroundColor: Color(0xffffffff),
                                      content: Container(
                                        width: double.maxFinite,
                                        height: 300,
                                        decoration: BoxDecoration(
                                          // color: Color(0xffdddddd),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Scrollbar(
                                            thumbVisibility: true,
                                            thickness: 2,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: _dayList.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 5,
                                                      bottom: 5,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Color(0xffeeeeee),
                                                  ),
                                                  child: ListTile(
                                                    title: Text(_dayList[index],
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                    onTap: () {
                                                      setState(() {
                                                        _payDate =
                                                            _dayList[index];
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'キャンセル',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ====================================================================================================


                    // ========================================== ⑤引き落とし銀行 ==========================================
                    betweenAddPaymentSection(),
                    Container(
                      padding: EdgeInsets.only(
                          left: 9, right: 9, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffededed),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addButtonPageTitleText(
                              Icons.account_balance_outlined, '引き落とし銀行を入力'),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fixedSize: Size(double.infinity, 70),
                                backgroundColor: Color(0xfffefefe),
                              ),
                              child: ListTile(
                                title: Text(
                                    '${_selectedBank ?? '未選択'}',
                                    style: TextStyle(fontSize: 20)),
                                trailing: Icon(Icons.edit),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('引き落とし銀行を選択：'),
                                      backgroundColor: Color(0xffffffff),
                                      content: Container(
                                        width: double.maxFinite,
                                        height: 300,
                                        decoration: BoxDecoration(
                                          // color: Color(0xffdddddd),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Scrollbar(
                                            thumbVisibility: true,
                                            thickness: 2,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: _bankList.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 5,
                                                      bottom: 5,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Color(0xffeeeeee),
                                                  ),
                                                  child: ListTile(
                                                    title: Text(_bankList[index],
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedBank = _bankList[index];
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'キャンセル',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ====================================================================================================



                    SizedBox(height: 80),

                    // =============================================== 保存ボタン ==============================================
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 57,
                      child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    '本当に保存しますか？',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('キャンセル',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('保存'),
                                    ),
                                  ],
                                );
                            });
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xfffff3f3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              side: BorderSide(
                                color: Color(0xffff7777),
                                width: 1.7,
                              )),
                          child: Text(
                            '保存して閉じる',
                            style: TextStyle(color: Color(0xffff7777), fontSize: 16),
                          )),
                    ),
                    // =======================================================================================================

                    SizedBox(height: 12),
                    Text(
                      '保存せずに閉じるには\n右上の×ボタン or 左上の<ボタン を押してください',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.black38,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                  ],
                ))));
  }
}
