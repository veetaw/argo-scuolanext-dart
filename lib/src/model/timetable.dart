import 'subject.dart';

class Week {
  List<Day> days = new List();

  Week({this.days});

  Week.fromJson(Map json) {
    for (int i = 0; i < 72; i += 12) {
      List<Hour> hours = new List();
      for (int j = i; j < i + 12; j++) {
        hours.add(new Hour.fromJson(json["dati"][j]));
      }
      days.add(new Day(dayOfTheWeek: i ~/ 12, hours: hours));
    }
  }
}

class Day {
  int dayOfTheWeek;
  List<Hour> hours = new List();

  Day({this.dayOfTheWeek, this.hours});
}

class Hour {
  int hour;
  List<Subject> subjects = new List();

  Hour({this.hour, this.subjects});

  Hour.fromJson(Map json) {
    hour = json["numOra"] - 1;
    try {
      subjects = json["lezioni"]
          .map((Map m) => new Subject(
              name: m["materia"] ?? "", teacher: m["docente"] ?? ""))
          .toList();
    } catch (_) {}
  }
}
