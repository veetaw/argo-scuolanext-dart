///Teacher
class Teacher {
  String name;
  String surname;
  String email;
  String teacherId;
  String subject;

  Teacher({this.name, this.surname, this.teacherId, this.subject});

  Teacher.fromJson(Map json) {
    name = json["docente"]["nome"];
    surname = json["docente"]["cognome"];
    email = json["docente"]["email"];
    teacherId = json["codMin"];
    subject = json["materie"];
  }
}
