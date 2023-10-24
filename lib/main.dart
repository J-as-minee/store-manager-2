import 'package:flutter/material.dart';
import 'package:store_manager_2/product_entry.dart';
import 'package:store_manager_2/product_list.dart';

Future<void> main() async {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => ProductList(),
      '/add': (context) => ProductAdd(),
      '/list': (context) => ProductList()
    },
  ));
}
