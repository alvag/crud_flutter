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
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) => _productItem(context, products[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _productItem(BuildContext context, Product product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              SizedBox(width: 20.0),
            ],
          ),
        ),
        color: Colors.red,
      ),
      child: Card(
        child: Column(
          children: <Widget>[
            (product.photo == null)
                ? Image(image: AssetImage('assets/images/no-image.png'))
                : FadeInImage(
                    image: NetworkImage(product.photo),
                    placeholder: AssetImage('assets/images/loading.gif'),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              title: Text('${product.title} - ${product.price}'),
              subtitle: Text(product.id),
              onTap: () => Navigator.pushNamed(context, ProductPage.routeName,
                  arguments: product),
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        productsProvider.deleteProduct(product.id);
      },
    );
  }
}

/* 
ListTile(
        title: Text('${product.title} - ${product.price}'),
        subtitle: Text(product.id),
        onTap: () => Navigator.pushNamed(context, ProductPage.routeName,
            arguments: product),
      )
 */
