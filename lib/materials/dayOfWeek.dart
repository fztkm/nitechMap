enum DayOfWeek {
  Mon,
  Tue,
  Wed,
  Thu,
  Fry,
}

int dayOfWeekToInt(DayOfWeek day) {
  switch (day) {
    case DayOfWeek.Mon:
      return 0;
    case DayOfWeek.Tue:
      return 1;
    case DayOfWeek.Wed:
      return 2;
    case DayOfWeek.Thu:
      return 3;
    case DayOfWeek.Fry:
      return 4;
  }
}

DayOfWeek? intToDayOfWeek(int day) {
  switch (day) {
    case 0:
      return DayOfWeek.Mon;
    case 1:
      return DayOfWeek.Tue;
    case 2:
      return DayOfWeek.Wed;
    case 3:
      return DayOfWeek.Thu;
    case 4:
      return DayOfWeek.Fry;
    default:
      return null;
  }
}

//曜日取得
DayOfWeek? intToDayOfWeekForIntl(int dow) {
  // int index = now.weekday; //Mon = 1, max7
  switch (dow) {
    case 1:
      print('Today is Mon');
      return DayOfWeek.Mon;
    case 2:
      print('Today is Tue');
      return DayOfWeek.Tue;
    case 3:
      print('Today is Tue');
      return DayOfWeek.Wed;
    case 4:
      print('Today is Tue');
      return DayOfWeek.Thu;
    case 5:
      print('Today is Tue');
      return DayOfWeek.Fry;
    default:
      print('Today is Holiday');
      return null;
  }
}
