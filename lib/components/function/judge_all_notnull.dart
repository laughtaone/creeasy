// 変数のリストを受け取り全てnullでないか返す関数
// import文：import 'package:creeasy/COMMON_COMPS/function/judge_all_notnull.dart';


bool judgeAllNotnull({required List<dynamic> rectList}) {
  for (var item in rectList) {
    if (item == null) {
      return false;
    }
  }
  return true;
}
