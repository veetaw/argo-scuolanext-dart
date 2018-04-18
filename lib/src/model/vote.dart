class Vote {
  String subject;
  String description;

  ///the utf8 representation of a vote, eg 8½
  String voteCode;
  String notes;
  String teacher;
  double vote;
  DateTime date;

  Vote(
      {this.date,
      this.subject,
      this.vote,
      this.description,
      this.voteCode,
      this.notes,
      this.teacher});

  Vote.fromJson(Map json) {
    subject = json["desMateria"];
    description = json["desProva"];
    voteCode = json["codVoto"];
    notes = json["desCommento"];
    teacher = json["docente"];
    vote = json["decValore"].toDouble();
    date = DateTime.parse(json["datGiorno"]);
  }
}
