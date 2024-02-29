import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/products_provider.dart';

class Add extends StatelessWidget {
  static String id = "add";
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Add"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter Product Details"),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: "Name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  labelText: "Description", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                  labelText: "Price", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String description = descriptionController.text;
                double price = double.parse(priceController.text);

                Product product =
                    Product(name: name, description: description, price: price);
                nameController.clear();
                descriptionController.clear();
                priceController.clear();
                Navigator.pop(context);
                await addProductToFirestore(product);
              },
              child: const Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addProductToFirestore(Product product) async {
    try {
      await FirebaseFirestore.instance.collection('Products').add({
        'name': product.name,
        'description': product.description,
        'price': product.price,
      });
    } catch (e) {
      print('Error adding product: $e');
    }
  }
}
