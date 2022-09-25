import 'package:sprintf/sprintf.dart';

/// DateTimeを日付の文字列表現に変換する
/// [dateTime] 日時
String makeDateString(DateTime dateTime) {
  final localDateTime = dateTime.toLocal();
  return sprintf("%04d/%02d/%02d", [
    localDateTime.year,
    localDateTime.month,
    localDateTime.day,
  ]);
}
