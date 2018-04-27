import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/absence.dart';
import 'model/school.dart';
import 'model/student.dart';
import 'model/teacher.dart';
import 'model/timetable.dart';
import 'model/vote.dart';

/// The client class
///
/// Remember to run firstLogin() or initClient() to properly use this class
class Client {
  final http.Client _client = new http.Client();
  static final Client _instance = new Client._internal();

  factory Client() {
    return _instance;
  }

  Client._internal();

  final List<String> _apiUrl = [
    "https",
    "www.portaleargo.it",
    "/famiglia/api/rest/"
  ];
  final String _apiKey = "ax6542sdru3217t4eesd9";
  final String _version = "2.0.2";
  final String _userAgent = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit"
      "/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 "
      "Safari/537.36";

  String token;
  String schoolCode;

  String _prgAlunno;
  String _prgScheda = "1";
  String _prgScuola;

  School school;
  Student student;

  /// firstLogin method
  ///
  /// Call this to login with username and password.
  /// Use [initClient] to login with token.
  Future<String> firstLogin(
      {String schoolCode, String username, String password}) async {
    assert(schoolCode != null && username != null && password != null);
    var resp = await _makeRequest(
        method: "login",
        schoolCode: schoolCode,
        username: username,
        password: password);

    this.schoolCode = schoolCode;
    token = resp["token"];

    await initClient(schoolCode: schoolCode, token: token);
    return token;
  }

  Future initClient({String schoolCode, String token}) async {
    assert(schoolCode != null && token != null);
    this.token = token;
    this.schoolCode = schoolCode;

    var response = await _makeRequest(method: "schede");

    school = new School.fromJson(response[0]);
    student = new Student.fromJson(response[0]);

    _prgScuola = school.schoolId.toString();
    _prgAlunno = student.studentId.toString();
  }

  /// absences
  ///
  /// Get a list of student's [Absence]
  Future absences() async {
    var response = await _makeRequest(method: "assenze");

    return new List<Absence>.generate(response["dati"].length,
        (int i) => new Absence.fromJson(response["dati"][i]));
  }

  Future whatHappened(DateTime date) async {
    return _makeRequest(method: "oggi", date: date); // TODO: test
  }

  Future notes() async {
    return _makeRequest(method: "notedisciplinari"); // TODO: test
  }

  /// votes
  ///
  /// get a list of [Vote]
  Future votes() async {
    return (await _makeRequest(method: "votigiornalieri"))["dati"]
        .map((Map v) => new Vote.fromJson(v))
        .toList();
  }

  Future homeworks() async {
    return _makeRequest(method: "compiti"); // TODO: test
  }

  Future reminders() async {
    return _makeRequest(method: "promemoria"); // TODO: test
  }

  ///timetable
  ///
  /// Returns a [Week] class
  Future<Week> timetable() async =>
      new Week.fromJson(await _makeRequest(method: "orario"));

  ///teachers
  ///
  /// Returns a list of [Teacher]
  Future teachers() async => (await _makeRequest(method: "docenticlasse"))
      .map((Map t) => new Teacher.fromJson(t))
      .toList();

  ///Private method to make requests to argo's APIs
  Future<dynamic> _makeRequest(
      {String method,
      String schoolCode,
      String username,
      String password,
      DateTime date}) async {
    if (date == null) date = new DateTime.now();

    http.Response response = await _client.get(
        new Uri(
          scheme: _apiUrl[0],
          host: _apiUrl[1],
          path: _apiUrl[2] + method,
          queryParameters: {
            "_dc": date.millisecondsSinceEpoch.toString(),
            "datGiorno": "${date.year}-${date.month.toString().padLeft(
                2, '0')}-${date.day.toString().padLeft(2, '0')}"
          },
        ),
        headers: {
          'x-key-app': _apiKey,
          'x-version': _version,
          'user-agent': _userAgent,
          'x-cod-min': schoolCode ?? this.schoolCode,
          'x-user-id': username,
          'x-pwd': password,
        }
          ..addAll(method == "login"
              ? {}
              : {
            'x-auth-token': token,
            'x-prg-alunno': this._prgAlunno,
            'x-prg-scuola': this._prgScuola,
            'x-prg-scheda': this._prgScheda
          }));

    if (response.statusCode != 200) {
      throw new Exception("$method failed\n${response.request}\n${response
          .statusCode} : ${response.body}");
    }

    return JSON.decode(response.body);
  }
}
