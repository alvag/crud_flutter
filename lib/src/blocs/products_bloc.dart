import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:crud_flutter/src/providers/products_provider.dart';

class ProductsBloc {
  final _productsCtrl = BehaviorSubject<List<Product>>();
  final _loadingCtrl = BehaviorSubject<bool>();

  final _productsProvider = new ProducstProvider();

  Stream<List<Product>> get productsStream => _productsCtrl.stream;
  Stream<bool> get loading => _loadingCtrl.stream;

  void loadProducts() async {
    final products = await _productsProvider.getAll();
    _productsCtrl.sink.add(products);
  }

  void createProduct(Product product) async {
    _loadingCtrl.sink.add(true);
    await _productsProvider.createProduct(product);
    _loadingCtrl.sink.add(false);
  }

  Future<String> uploadImage(File photo) async {
    _loadingCtrl.sink.add(true);
    final photoUrl = await _productsProvider.uploadImage(photo);
    _loadingCtrl.sink.add(false);
    return photoUrl;
  }

  void updateProduct(Product product) async {
    _loadingCtrl.sink.add(true);
    await _productsProvider.updateProduct(product);
    _loadingCtrl.sink.add(false);
  }

  void deleteProduct(String id) async {
    await _productsProvider.deleteProduct(id);
  }

  dispose() {
    _productsCtrl?.close();
    _loadingCtrl?.close();
  }
}
