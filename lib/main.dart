import 'package:flutter/material.dart';
import 'package:crud_flutter/src/blocs/provider.dart';
import 'package:crud_flutter/src/pages/home_page.dart';
import 'package:crud_flutter/src/pages/login_page.dart';
import 'package:crud_flutter/src/pages/register_page.dart';
import 'package:crud_flutter/src/pages/product_page.dart';
import 'package:crud_flutter/src/shared_preferences/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final prefs = new UserPreferences();
  final initialRoute =
      prefs.token == null ? LoginPage.routeName : HomePage.routeName;

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: initialRoute,
        routes: {
          LoginPage.routeName: (context) => LoginPage(),
          HomePage.routeName: (context) => HomePage(),
          ProductPage.routeName: (context) => ProductPage(),
          RegisterPage.routeName: (context) => RegisterPage()
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
