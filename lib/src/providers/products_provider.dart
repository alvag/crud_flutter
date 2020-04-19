import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:crud_flutter/src/models/product_model.dart';
export 'package:crud_flutter/src/models/product_model.dart';

class ProducstProvider {
  final String _url = 'https://flutter-varios-cd3e1.firebaseio.com';

  Future<bool> createProduct(Product product) async {
    final url = '$_url/products.json';

    final resp = await http.post(url, body: productModelToJson(product));
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }
}
