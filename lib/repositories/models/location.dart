import 'package:swipezone/repositories/models/weekly_schedule.dart';

import 'activities.dart';
import 'categories.dart';
import 'contact.dart';
import 'localization.dart';

class Location {
  String nom;
  String? description;
  WeeklySchedule? schedule;
  Contact? contact;
  String? photoUrl;
  Categories category;
  List<Activities>? activities;
  Localization localization;

  Location(this.nom, this.description, this.schedule, this.contact,
      this.photoUrl, this.category, this.activities, this.localization);
}
