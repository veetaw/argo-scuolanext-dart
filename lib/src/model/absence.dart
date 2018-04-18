///Absence model
///
///The model of a student's absence
class Absence {
  ///the teacher who registered the absence
  String registeredBy;
  String description;

  ///absence code
  String code;
  bool justified;

  ///the hour when you joined the lesson
  int joinedLessonAt;
  DateTime date;

  Absence(
      {this.joinedLessonAt,
      this.code,
      this.date,
      this.justified,
      this.description,
      this.registeredBy});

  Absence.fromJson(Map json) {
    joinedLessonAt = json["numOra"];
    code = json["codEvento"];
    date = DateTime.parse(json["datAssenza"]);
    justified = !json["flgDaGiustificare"];
    registeredBy = json["registrataDa"];
  }
}
