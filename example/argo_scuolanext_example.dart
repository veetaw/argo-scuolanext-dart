import 'dart:io';

import 'package:argo_scuolanext/argo_scuolanext.dart';

main() async {
  Client client = new Client();
  String schoolCode, username, password;

  print("Type your school code: ");
  schoolCode = await stdin.readLineSync();

  print("Now your username: ");
  username = await stdin.readLineSync();

  print("and your password: ");
  // that's not nice, need to check if exists a way to obscure input
  password = await stdin.readLineSync();

  await client.firstLogin(
      schoolCode: schoolCode, username: username, password: password);

  print("Your timetable:\n");
  (await client.timetable())
      .days
      .map((d) => d.hours.map((h) => h.subjects.map((s) => s.teacher)))
      .forEach(print); // <3 dart
}
