import 'package:flutter/material.dart';


// 保存ボタン
class SaveButtonComp extends StatefulWidget {
  final Function onSave;
  final bool isCanOnpress;

  SaveButtonComp(
      {required this.onSave,
      this.isCanOnpress = false // 押せるかどうかの真偽値(デフォでfalse=押せない)
      });

  @override
  _SaveButtonCompState createState() => _SaveButtonCompState();
}

class _SaveButtonCompState extends State<SaveButtonComp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 30),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            height: 57,
            width: double.infinity,
            child: OutlinedButton(
                // --------------------------------------- ダイアログ表示 ---------------------------------------
                onPressed: (widget.isCanOnpress)
                    ? () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  '本当に保存しますか？',
                                  style: TextStyle(fontSize: 20),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => {Navigator.pop(context)},
                                    child: Text('キャンセル',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      widget.onSave();
                                      Navigator.pop(context);
                                    },
                                    child: Text('保存'),
                                  ),
                                ],
                              );
                            });
                      }
                    : null,
                // ----------------------------------------------------------------------------------------------
                style: OutlinedButton.styleFrom(
                    backgroundColor: (widget.isCanOnpress)
                        ? Color(0xfffff0f0)
                        : Color(0xfff0f0f0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(
                      color: (widget.isCanOnpress)
                          ? Color(0xffff6666)
                          : Color(0xff959595),
                      width: 1.7,
                    )),
                child: Text(
                  '保存して閉じる',
                  style: TextStyle(
                      color: (widget.isCanOnpress)
                          ? Color(0xffff5555)
                          : Color(0xff909090),
                      fontSize: 16),
                )),
          ),
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
      ),
    );
  }
}