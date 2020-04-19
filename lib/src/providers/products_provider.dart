import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:crud_flutter/src/models/product_model.dart';
export 'package:crud_flutter/src/models/product_model.dart';

class ProducstProvider {
  final String _url = 'https://flutter-varios-cd3e1.firebaseio.com';

  Future<bool> createProduct(Product product) async {
    final url = '$_url/products.json';

    final res = await http.post(url, body: productModelToJson(product));
    final decodedData = json.decode(res.body);

    print(decodedData);

    return true;
  }

  Future<List<Product>> getAll() async {
    final url = '$_url/products.json';

    final res = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(res.body);

    final List<Product> products = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final p = Product.fromJson(prod);
      p.id = id;
      products.add(p);
    });

    return products;
  }

  Future<bool> deleteProduct(String id) async {
    final url = '$_url/products/$id.json';
    final res = await http.delete(url);

    return true;
  }
}
