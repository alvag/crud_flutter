import 'package:flutter/material.dart';
import 'package:crud_flutter/src/blocs/provider.dart';
import 'package:crud_flutter/src/pages/home_page.dart';
import 'package:crud_flutter/src/pages/login_page.dart';
import 'package:crud_flutter/src/pages/register_page.dart';
import 'package:crud_flutter/src/pages/product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: LoginPage.routeName,
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
