import 'package:flutter/material.dart';
import 'package:crud_flutter/src/pages/product_page.dart';
import 'package:crud_flutter/src/blocs/provider.dart';
import 'package:crud_flutter/src/providers/products_provider.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';
  final productsProvider = new ProducstProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: _productsList(),
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

  Widget _productsList() {
    return FutureBuilder(
      future: productsProvider.getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData) {
          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
