import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeFormatter extends GetxController{


  /// 🔹 Human readable format (যেমন: "Today", "Yesterday", বা তারিখ)
  String getReadableTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime).inDays;

    if (difference == 0) {
      return "Today ${DateFormat('hh:mm a').format(dateTime)}";
    } else if (difference == 1) {
      return "Yesterday ${DateFormat('hh:mm a').format(dateTime)}";
    } else {
      return DateFormat('MMM d, yyyy • hh:mm a').format(dateTime);
    }
  }

}