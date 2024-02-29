import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String description;
  final double price;

  Product({required this.name, required this.description, required this.price});
}

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Products').get();
      _products = snapshot.docs.map((doc) {
        return Product(
          name: doc['name'],
          description: doc['description'],
          price: doc['price'].toDouble(),
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching products from Firestore: $e');
    }
  }
}
