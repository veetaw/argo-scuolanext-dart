# Argo ScuolaNext
A ScuolaNext **UNOFFICIAL** API wrapper written in Dart.

This package can be used on both Dart (Web & CLI) and Flutter.

## Usage

First import this package with:
```dart
import 'package:argo_scuolanext/argo_scuolanext.dart';
```
then instantiate a Client object:
```dart
Client client = new Client();
```
#### Login
There are two ways to login, with school code, user and password and with school code and token.
Do the first login using the first way:
```dart
await client.firstLogin(
  schoolCode: "ssXXXX",
  username: "XXXXXXXXXX",
  password: "XXXXXXXXXXXXXXXXXXXXX",
 );
```
then save the token:
```dart
String token = client.token;  // obviously run this after login
```
so next time you can login with:
```dart
await client.initClient(
  schoolCode: "ssXXXX",
  token: token,
);
```

#### Example
see example/

#### docs
To build dart docs just cd into this directory and then run
```bash
dartdoc
```

#### TODO
- implement scrutiny in votes()
- test all methods of client()

#### special thanks
- [@cristianlivella](https://github.com/cristianlivella) for his [wrapper](https://github.com/cristianlivella/ArgoAPI).
- [@hearot](https://github.com/hearot/) for his [python wrapper](https://github.com/hearot/ArgoScuolaNext-Python)
