import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:crud_flutter/src/blocs/validators.dart';

class LoginBloc with Validators {
  final _emailCtrl = BehaviorSubject<String>();
  final _passwordCtrl = BehaviorSubject<String>();

  // recuperar los datos del stream
  Stream<String> get emailStream => _emailCtrl.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordCtrl.stream.transform(passwordValidator);

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);
  // insertar valores al stream
  Function(String) get changeEmail => _emailCtrl.sink.add;
  Function(String) get changePassword => _passwordCtrl.sink.add;

  // obtener el último valor ingresado a los treams

  String get email => _emailCtrl.value;
  String get password => _passwordCtrl.value;

  dispose() {
    _emailCtrl?.close();
    _passwordCtrl?.close();
  }
}
