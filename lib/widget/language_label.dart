import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_sample/resource/languages.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';

/// 言語ラベル
class LanguageLabel extends StatelessWidget {
  final String _language;

  const LanguageLabel(this._language, {super.key});

  @override
  Widget build(BuildContext context) {
    // プログラミング言語ラベルの色
    Color languageColor = MyColors.other;
    if (Languages.colorMap.containsKey(_language)) {
      languageColor = Languages.colorMap[_language] ?? MyColors.other;
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      alignment: Alignment.center,
      height: 28,
      decoration: BoxDecoration(
          color: languageColor, borderRadius: BorderRadius.circular(14)),
      child: Text(
        _language,
        style: const TextStyle(
            color: MyColors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
