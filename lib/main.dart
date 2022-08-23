import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorbin/controller/products_provider.dart';
import 'package:tutorbin/view/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Products(title: 'Buy New Item'),
      ),
    );
  }
}
