import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ta2set_app/providers/installment_provider.dart';
import 'package:ta2set_app/providers/product_provider.dart';
import 'package:ta2set_app/providers/products_provider.dart';
import 'package:ta2set_app/screens/login/login_screen.dart';
import 'providers/customer_provider.dart';
import 'providers/supplier_provider.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => SupplierProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CustomerProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => InstallmentProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
          backgroundColor: Colors.blue[900],
          iconTheme: IconThemeData(color: Colors.blue[900], size: 45),
        ),
        home: LoginScreen(),
      ),
    );
  }
}
