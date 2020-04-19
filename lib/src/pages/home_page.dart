import 'package:flutter/material.dart';
import 'package:crud_flutter/src/pages/product_page.dart';
import 'package:crud_flutter/src/blocs/provider.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Container(),
      floatingActionButton: _floatActionButton(context),
    );
  }

  Widget _floatActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, ProductPage.routeName),
    );
  }
}
