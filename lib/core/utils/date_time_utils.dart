import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String dateTimeFormatPattern = 'dd/MM/yyyy';
const String Y_M_D = 'y.M.d';
const String H_M = 'H:m';extension DateTimeExtension on DateTime {
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

  /// 將「總秒數」轉換為中文格式時間字串
  /// 支援輸出：
  /// - "h小時m分鐘s秒"
  /// - "h小時m分鐘"
  /// - "h小時s秒"
  /// - "h小時"
  /// - "m分鐘s秒"
  /// - "m分鐘"
  /// - "s秒"
  static String formatDurationCN(int totalSeconds) {
    if (totalSeconds < 0) totalSeconds = 0;

    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;

    final List<String> parts = [];

    if (hours > 0) parts.add('${hours}小時');
    if (minutes > 0) parts.add('${minutes}分鐘');
    if (seconds > 0 || parts.isEmpty) parts.add('${seconds}秒');

    return parts.join('');
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
    if (seconds < 1000) {
      return "${hours.toStringAsFixed(2)}h";
    }
    return "${hours.toStringAsFixed(1)}h";
  }

  static String formatMaxTimestamp(int ts1, int ts2, int ts3) {
    final int maxTs = [ts1, ts2, ts3].reduce((a, b) => a > b ? a : b);
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(maxTs * 1000);
    return DateFormat('yyyy/MM/dd HH:mm').format(dateTime);
  }

  /// 取得兩個時間點之間的秒數
  static int getDurationInSeconds(int startTimestamp, int endTimestamp) {
    return endTimestamp - startTimestamp;
  }

  static formatToChineseDate(String rawDate) {
    final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    final dateTime = inputFormat.parse(rawDate);
    return "${dateTime.month}月${dateTime.day}日";
  }

  /// 查詢：日的時間區間
  Map<String, DateTime> getDailyRange(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(Duration(days: 1)).subtract(Duration(seconds: 1));
    return {"start": start, "end": end};
  }

  /// 查詢：週的時間區間（從週一開始）
  Map<String, DateTime> getWeeklyRange(DateTime date) {
    final start = date.subtract(Duration(days: date.weekday - 1));
    final end = start.add(Duration(days: 7)).subtract(Duration(seconds: 1));
    return {"start": start, "end": end};
  }

  /// 查詢：月的時間區間
  Map<String, DateTime> getMonthlyRange(DateTime date) {
    final start = DateTime(date.year, date.month, 1);
    final end =
        DateTime(date.year, date.month + 1, 1).subtract(Duration(seconds: 1));
    return {"start": start, "end": end};
  }

  /// 查詢：日，週，月
  static Map<String, DateTime> getRangeByIndex(DateTime date, int index) {
    late DateTime start;
    late DateTime end;

    if (index == 0) {
      start = DateTime(date.year, date.month, date.day);
      end = start
          .add(const Duration(days: 1))
          .subtract(const Duration(seconds: 1));
    } else if (index == 1) {
      start = DateTime(date.year, date.month, date.day);
      end = start
          .add(const Duration(days: 7))
          .subtract(const Duration(seconds: 1));
    } else {
      start = DateTime(date.year, date.month, 1);
      end = DateTime(date.year, date.month + 1, 1)
          .subtract(const Duration(seconds: 1));
    }
    return {"start": start, "end": end};
  }
}
