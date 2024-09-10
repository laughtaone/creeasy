import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/no_save_close_comp.dart';


// 保存ボタン
class SaveButtonComp extends StatefulWidget {
  final Function argCallback;
  final bool isCanOnpress;
  final int? messageType;

  const SaveButtonComp(
      {super.key, required this.argCallback,
      this.isCanOnpress = false, // 押せるかどうかの真偽値(デフォでfalse=押せない)
      this.messageType = 0
      });

  @override
  _SaveButtonCompState createState() => _SaveButtonCompState();
}

class _SaveButtonCompState extends State<SaveButtonComp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 30),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
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
                                title: const Text(
                                  '本当に保存しますか？',
                                  style: TextStyle(fontSize: 20),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => {Navigator.pop(context)},
                                    child: const Text('キャンセル',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      widget.argCallback();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('保存'),
                                  ),
                                ],
                              );
                            });
                      }
                    : null,
                // ----------------------------------------------------------------------------------------------
                style: OutlinedButton.styleFrom(
                    backgroundColor: (widget.isCanOnpress)
                        ? const Color(0xfffff0f0)
                        : const Color(0xfff0f0f0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(
                      color: (widget.isCanOnpress)
                          ? const Color(0xffff6666)
                          : const Color(0xff959595),
                      width: 1.7,
                    )),
                child: Text(
                  '保存して閉じる',
                  style: TextStyle(
                      color: (widget.isCanOnpress)
                          ? const Color(0xffff5555)
                          : const Color(0xff909090),
                      fontSize: 16),
                )),
          ),
          (widget.messageType!=-1)
          ? noSaveCloseComp(messageType: widget.messageType)
          : const SizedBox.shrink(),
        ],
      ),
    );
  }
}