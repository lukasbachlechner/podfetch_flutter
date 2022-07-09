import 'package:intl/intl.dart';

enum DateFormattingType { monthYear, full }

String formatDate(DateTime date,
    {DateFormattingType type = DateFormattingType.monthYear}) {
  final formats = {
    DateFormattingType.monthYear: DateFormat('MMMM y'),
    DateFormattingType.full: DateFormat.yMd(),
  };
  final formatter = formats[type]!;
  return formatter.format(date);
}
