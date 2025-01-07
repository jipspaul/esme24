class Schedule {
  DateTime openAt;
  DateTime closeAt;

  Schedule({required this.openAt, required this.closeAt});
}

class DailySchedule {
  List<Schedule> schedules;

  DailySchedule({required this.schedules});
}

class WeeklySchedule {
  List<DailySchedule> dailySchedules;

  WeeklySchedule({required this.dailySchedules});
}
