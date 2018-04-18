///School
///
///This model contains school informations like name and id
class School {
  String name;
  String instituteName;

  /// ministerial code of the school
  String code;
  String type;
  int schoolId;
  DateTime schoolYearStart;
  DateTime schoolYearEnd;

  School(
      {this.name,
      this.schoolId,
      this.instituteName,
      this.code,
      this.type,
      this.schoolYearStart});

  School.fromJson(Map<String, dynamic> json) {
    name = json["desScuola"];
    schoolId = json["prgScuola"];
    instituteName = json["desSede"];
    code = json["codMin"];
    type = json["desDenominazione"];
    schoolYearStart = DateTime.parse(json["annoScolastico"]["datInizio"]);
    schoolYearEnd = DateTime.parse(json["annoScolastico"]["datFine"]);
  }
}
