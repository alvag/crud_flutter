import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:crud_flutter/src/shared_preferences/user_preferences.dart';
import 'package:crud_flutter/src/models/product_model.dart';
export 'package:crud_flutter/src/models/product_model.dart';

class ProducstProvider {
  final String _url = 'https://flutter-varios-cd3e1.firebaseio.com';
  final _prefs = new UserPreferences();

  Future<bool> createProduct(Product product) async {
    final url = '$_url/products.json?auth=${_prefs.token}';

    final res = await http.post(url, body: productModelToJson(product));
    final decodedData = json.decode(res.body);

    print(decodedData);

    return true;
  }

  Future<bool> updateProduct(Product product) async {
    final url = '$_url/products/${product.id}.json?auth=${_prefs.token}';

    final res = await http.put(url, body: productModelToJson(product));
    final decodedData = json.decode(res.body);

    print(decodedData);

    return true;
  }

  Future<List<Product>> getAll() async {
    final url = '$_url/products.json?auth=${_prefs.token}';

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
    final url = '$_url/products/$id.json?auth=${_prefs.token}';
    final res = await http.delete(url);

    return true;
  }

  Future<String> uploadImage(File image) async {
    // https://api.cloudinary.com/v1_1/dxwkusacu/image/upload?upload_preset=wmvuexu4

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dxwkusacu/image/upload?upload_preset=wmvuexu4');
    final mimeType = mime(image.path).split('/');
    final request = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    request.files.add(file);

    final streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      return null;
    } else {
      final responseData = json.decode(response.body);
      print(responseData);
      return responseData['secure_url'];
    }
  }
}
