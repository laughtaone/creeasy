// 引数の型を指定

class SotbProperties {
  final String upperText;
  final String trueLowerText;
  final String falseLowerText;
  final bool initialBoolLowerText;
  final int listIndexNum;
  // final Function argCallback;

  SotbProperties({
    required this.upperText,
    required this.trueLowerText,
    required this.falseLowerText,
    required this.initialBoolLowerText,
    required this.listIndexNum,
    // required this.argCallback,
  });

  // 属性の更新を行うメソッド
  SotbProperties copyWith({
    String? upperText,
    String? trueLowerText,
    String? falseLowerText,
    bool? initialBoolLowerText,
    int? listIndexNum,
    Function? argCallback,
  }) {
    return SotbProperties(
      upperText: upperText ?? this.upperText,
      trueLowerText: trueLowerText ?? this.trueLowerText,
      falseLowerText: falseLowerText ?? this.falseLowerText,
      initialBoolLowerText: initialBoolLowerText ?? this.initialBoolLowerText,
      listIndexNum: listIndexNum ?? this.listIndexNum,
    );
  }
}
