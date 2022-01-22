import 'dart:convert';
import 'package:firebase_forms/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirebaseProvider extends ChangeNotifier {
  final String _baseURL = 'flutter-demo-34136-default-rtdb.firebaseio.com';

  final List<ProductModel> productList = [];

  bool isLoading = true;

  FirebaseProvider() {
    loadProductTable();
  }

  Future<List<ProductModel>> loadProductTable() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseURL, '/products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final parsedProduct = ProductModel.fromMap(value);
      parsedProduct.id = key;
      productList.add(parsedProduct);
    });

    isLoading = false;
    notifyListeners();

    return productList;
  }

  Future<String> createProduct(ProductModel product) async {
    productList.add(product);

    final url = Uri.https(_baseURL, '/products/.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedProduct = json.decode(resp.body);

    product.id = decodedProduct['name'];
    return await updateProduct(product);
  }

  Future<String> updateProduct(ProductModel product) async {
    int index = productList.indexWhere((element) => element.id == product.id);
    productList[index] = product;

    final url = Uri.https(_baseURL, '/products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedProduct = json.decode(resp.body);
    //print(decodedProduct);
    notifyListeners();

    return '${product.id}';
  }
}
