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

  /// 將秒數轉換為「8 小時 23 分鐘」格式
  static String formatSecondsToHourMinute(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return "$hours 小時 $minutes 分鐘";
    } else if (hours > 0) {
      return "$hours 小時";
    } else {
      return "$minutes 分鐘";
    }
  }

  /// 比對兩個時間點並計算出時間差，返回「8 小時 23 分鐘」格式
  static String getDurationFormattedString(
      int startTimestamp, int endTimestamp) {
    final durationInSeconds = endTimestamp - startTimestamp;

    final hours = durationInSeconds ~/ 3600;
    final minutes = (durationInSeconds % 3600) ~/ 60;

    return "${hours}小時${minutes}分鐘";
  }

  /// 只取小數表示，回傳「2.3h」這種格式（保留 1 位小數）
  static String formatSecondsToHourDecimal(int seconds) {
    final hours = seconds / 3600;
    return "${hours.toStringAsFixed(1)}h";
  }

  static String formatMaxTimestamp(int ts1, int ts2, int ts3, int ts4) {
    final int maxTs = [ts1, ts2, ts3, ts4].reduce((a, b) => a > b ? a : b);
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(maxTs * 1000);
    return DateFormat('yyyy/MM/dd HH:mm').format(dateTime);
  }
}
