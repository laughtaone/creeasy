import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/appbar/common_appbar_comp.dart';


class MoneyManagePage extends StatefulWidget {
  const MoneyManagePage({super.key});

  @override
  _MoneyManagePageState createState() => _MoneyManagePageState();
}


class _MoneyManagePageState extends State<MoneyManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarComp(
        context: context,
        recvIcon: Icons.task_alt_outlined,
        recvText: '利用履歴管理'
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      ),
    );
  }
}