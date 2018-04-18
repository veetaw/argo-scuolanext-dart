import 'package:argo_scuolanext/argo_scuolanext.dart';
import 'package:test/test.dart';

void main() {
  // todo test argo requests
  group('model parsing tests', () {
    Absence absence;
//    todo test
//    Reminder reminder;
//    School school;
//    Subject subject;
//    Teacher teacher;
//    Week week;
//    Vote vote;

    setUp(() async {
      absence = new Absence.fromJson({
        "numOra": 2,
        "codEvento": "...",
        "datAssenza": "2018-04-18",
        "flgDaGiustificare": true,
        "registrataDa": "..."
      });
    });

    test('test Absence', () {
      expect(absence.joinedLessonAt, 2);
      expect(absence.justified, isFalse);
      expect(
          DateTime.parse("2018-04-18").isAtSameMomentAs(absence.date), isTrue);
      expect(absence.registeredBy, "...");
      expect(absence.code, "...");
    });
  });
}
