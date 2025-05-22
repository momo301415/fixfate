import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String dateTimeFormatPattern = 'dd/MM/yyyy';

extension DateTimeExtension on DateTime {
  String format({
    String pattern = dateTimeFormatPattern,
    String? locale,
  }) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}

class DateTimeUtils {
  static String getTimeDifferenceString(int timestamp) {
    final int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final int diffInSeconds = now - timestamp;

    if (diffInSeconds < 60) {
      return "$diffInSeconds 秒前";
    } else if (diffInSeconds < 3600) {
      final minutes = diffInSeconds ~/ 60;
      return "$minutes 分鐘前";
    } else if (diffInSeconds < 86400) {
      final hours = diffInSeconds ~/ 3600;
      return "$hours 小時前";
    } else {
      final days = diffInSeconds ~/ 86400;
      return "$days 天前";
    }
  }

  static String formatMaxTimestamp(int ts1, int ts2, int ts3, int ts4) {
    final int maxTs = [ts1, ts2, ts3, ts4].reduce((a, b) => a > b ? a : b);
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(maxTs * 1000);
    return DateFormat('yyyy/MM/dd HH:mm').format(dateTime);
  }
}
