enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
}

int dayOfWeekToInt(DayOfWeek day) {
  switch (day) {
    case DayOfWeek.Monday:
      return 0;
    case DayOfWeek.Tuesday:
      return 1;
    case DayOfWeek.Wednesday:
      return 2;
    case DayOfWeek.Thursday:
      return 3;
    case DayOfWeek.Friday:
      return 4;
  }
}

String getDayOfWeekStringByInt(int day) {
  switch (day) {
    case 0:
      return "月";
    case 1:
      return "火";
    case 2:
      return "水";
    case 3:
      return "木";
    case 4:
      return "金";
    default:
      return "エラー";
  }
}

DayOfWeek? intToDayOfWeek(int day) {
  switch (day) {
    case 0:
      return DayOfWeek.Monday;
    case 1:
      return DayOfWeek.Tuesday;
    case 2:
      return DayOfWeek.Wednesday;
    case 3:
      return DayOfWeek.Thursday;
    case 4:
      return DayOfWeek.Friday;
    default:
      return null;
  }
}

//曜日取得
DayOfWeek? intToDayOfWeekForIntl(int dow) {
  // int index = now.weekday; //Mon = 1, max7
  switch (dow) {
    case 1:
      print('Today is Monday');
      return DayOfWeek.Monday;
    case 2:
      print('Today is Tuesday');
      return DayOfWeek.Tuesday;
    case 3:
      print('Today is Wednesday');
      return DayOfWeek.Wednesday;
    case 4:
      print('Today is Thursday');
      return DayOfWeek.Thursday;
    case 5:
      print('Today is Friday');
      return DayOfWeek.Friday;
    default:
      print('Today is Holiday');
      return null;
  }
}
