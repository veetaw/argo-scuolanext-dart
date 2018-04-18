///Student
///
///Model containing a student's profile
class Student {
  String name;
  String surname;

  ///can be m (male) or f (female)
  String sex;

  ///"codice fiscale"
  String cf; // NIN
  String address;
  String zipCode;
  String phoneNumber;
  String course;
  int studentId;
  int classId;
  DateTime birth;

  Student(
      {this.name,
      this.surname,
      this.cf,
      this.address,
      this.sex,
      this.zipCode,
      this.phoneNumber,
      this.studentId,
      this.classId,
      this.course});

  Student.fromJson(Map<String, dynamic> json) {
    name = json["alunno"]["desNome"];
    surname = json["alunno"]["desCognome"];
    cf = json["alunno"]["desCf"];
    address = json["alunno"]["desVia"];
    sex = json["alunno"]["flgSesso"];
    zipCode = json["alunno"]["desCap"];
    phoneNumber = json["alunno"]["desCellulare"];
    birth = DateTime.parse(json["alunno"]["datNascita"]);

    studentId = json["prgAlunno"];
    classId = json["prgClasse"];
    course = json["desCorso"];
  }
}
