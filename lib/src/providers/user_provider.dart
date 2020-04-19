import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {
  final String _firebaseKey = '';

  Future<Map<String, dynamic>> createUser(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseKey';

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final res = await http.post(url, body: json.encode(authData));

    Map<String, dynamic> decodedRes = json.decode(res.body);

    print(decodedRes);

    if (decodedRes.containsKey('idToken')) {
      return {'ok': true, 'token': decodedRes['idToken']};
    } else {
      return {'ok': false, 'message': decodedRes['error']['message']};
    }
  }

  login(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseKey';

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final res = await http.post(url, body: json.encode(authData));

    Map<String, dynamic> decodedRes = json.decode(res.body);

    print(decodedRes);

    if (decodedRes.containsKey('idToken')) {
      return {'ok': true, 'token': decodedRes['idToken']};
    } else {
      return {'ok': false, 'message': decodedRes['error']['message']};
    }
  }
}
