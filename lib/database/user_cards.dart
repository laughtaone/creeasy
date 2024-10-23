import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCards extends Notifier<List<Map>> {
  // 初期状態を設定・Notifierが初めて作成されるとこのメソッドが呼ばれる
  @override
  List<Map> build() {
    return [];
  }

  // 引数で渡されたresvListでstateを更新する
  // stateを更新することでリスナーに変更を通知できる
  void update(List<Map> resvList) {
    state = resvList;
  }
}

final userCardsProvider = NotifierProvider<UserCards, List<Map>>(() {
  return UserCards();
});