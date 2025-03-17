class AppUtils {
  static DateTime firstDateOfWeek({DateTime? date}) {
    final now = DateTime.now();
    final dateOnly = date ?? DateTime(now.year, now.month, now.day);
    DateTime firstDay = dateOnly.subtract(Duration(days: dateOnly.weekday - 1));
    return firstDay;
  }

  static DateTime lastDateOfWeek({DateTime? date}) {
    final now = DateTime.now();
    final dateOnly = date ?? DateTime(now.year, now.month, now.day);
    DateTime firstDay =
        dateOnly.add(Duration(days: DateTime.daysPerWeek - dateOnly.weekday));
    return firstDay;
  }
}
