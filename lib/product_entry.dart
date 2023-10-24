import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'product.dart';
import 'dart:convert';
import 'product_list.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final textController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  final String name = "";
  final int price = 0;
  final int quantity = 0;



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30.0),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Product Name',
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Product Price',
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Product Quantity',
                    ),
                  ),
                ),
                SizedBox(height: 50.0),

                ElevatedButton(
                  onPressed: () async {
                    print('Before creating product');

                    Product newProduct = createNewProduct();

                    if (newProduct.prodPrice != 0 && newProduct.prodQuantity != 0) {

                      List<Product> productList = await fetchProductsFromLocalStorage();
                      productList.add(newProduct);
                      saveProductsToLocalStorage(productList);

                      print('Done!');

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductList()));
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Shared Preference
  Product createNewProduct() {
    String name = textController.text;
    int price = 0;
    int quantity = 0;

    try {
      price = int.parse(priceController.text);
    } catch (e) {
      print('Invalid price format: ${priceController.text}');
    }

    try {
      quantity = int.parse(quantityController.text);
    } catch (e) {
      print('Invalid quantity format: ${quantityController.text}');
    }

    return Product(name, price, quantity);
  }

  Future<List<Product>> fetchProductsFromLocalStorage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> productsJsonList = sp.getStringList('products') ?? [];

    return productsJsonList
        .map((productJson) => Product.fromJson(jsonDecode(productJson)))
        .toList();
  }

  void saveProductsToLocalStorage(List<Product> productList) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> productsJsonList =
        productList.map((product) => jsonEncode(product.toJson())).toList();
    sp.setStringList('products', productsJsonList);
  }
}
