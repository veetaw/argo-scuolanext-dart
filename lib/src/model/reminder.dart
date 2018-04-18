///Reminder
class Reminder {
  String teacher;
  String reminder;
  DateTime date;

  Reminder({this.teacher, this.reminder});

  Reminder.fromJson(Map json) {
    teacher = json["desMittente"];
    reminder = json["desAnnotazioni"];
    date = DateTime.parse(json["datGiorno"]);
  }
}
