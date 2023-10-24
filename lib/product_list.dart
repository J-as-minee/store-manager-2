import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ChaquopyPlugin.dart';
import 'product.dart';
import 'dart:convert';

class ProductList extends StatefulWidget {
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String prodName = '';
  int prodPrice = 0;
  int prodQuantity = 0;

  List<Product> productList = [];

  String _zipFilePath = '';

  @override
  void initState() {
    super.initState();
    retrieveProductInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Products'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add');
                  },
                  child: Text('ADD PRODUCT'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(150, 50),
                  ),
                ),
              ),
              Align(
                child: ElevatedButton(
                  onPressed: () {
                    _generateZipFile();
                  },
                  child: Text('GENERATE HTML'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(150, 50),
                  ),
                ),
              ),
            ],
          ),
          for (var product in productList)
            ListTile(
              title: Text('Product Name: ${product.prodName}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: ${product.prodPrice}'),
                  Text('Quantity: ${product.prodQuantity}'),
                ],
              ),
            ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }

  Future<void> _generateZipFile() async {

    print('in genrate function');
    final zipFilePath =
        await ChaquopyPluginClass.runPythonScript('assets/test.py');

    print('zipFilepath: $zipFilePath');

    setState(() {
      _zipFilePath = zipFilePath;
    });
  }

  void retrieveProductInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // prodName = sp.getString('prodName') ?? '';
    // prodPrice = sp.getInt('prodPrice') ?? 0;
    // prodQuantity = sp.getInt('prodQuantity') ?? 0;
    List<String> productsJsonList = sp.getStringList('products') ?? [];

    productList = productsJsonList
        .map((productJson) => Product.fromJson(jsonDecode(productJson)))
        .toList();

    setState(() {});
  }
}
