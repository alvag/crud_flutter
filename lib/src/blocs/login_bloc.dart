import 'dart:async';

class LoginBloc {
  final _emailCtrl = StreamController<String>.broadcast();
  final _passwordCtrl = StreamController<String>.broadcast();

  // recuperar los datos del stream
  Stream<String> get emailStream => _emailCtrl.stream;
  Stream<String> get passwordStream => _passwordCtrl.stream;

  // insertar valores al stream
  Function(String) get changeEmail => _emailCtrl.sink.add;
  Function(String) get changePassword => _passwordCtrl.sink.add;

  dispose() {
    _emailCtrl?.close();
    _passwordCtrl?.close();
  }
}
