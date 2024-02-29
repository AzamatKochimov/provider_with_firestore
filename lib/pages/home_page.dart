import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import 'add_page.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  static String id = "home-page";
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    
    Provider.of<ProductProvider>(context, listen: true).fetchProducts();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text("All Products"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        elevation: 0.0,
        onPressed: () {
          Navigator.pushNamed(context, Add.id);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          if (productProvider.products.isEmpty) {
            productProvider
                .fetchProducts();
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical:10,),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    trailing: Text("\$${product.price.toStringAsFixed(2)}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
