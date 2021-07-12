import 'package:flutter/foundation.dart';
import 'package:ta2set_app/models/products.dart';

class ProductsProvider with ChangeNotifier {
  List<Products> _products = [];
  List<Products> get allProducts {
    return [..._products];
  }

  List<Products> _customerProducts = [];
  List<Products> get allCutsomerProducts {
    return [..._customerProducts];
  }

  Future<void> fetchAndSetProducts() async {
    final dataList = Products().allproducts();
    _products = await dataList;
    notifyListeners();
  }

  Future<void> customerProducts(int id) async {
    final customerProductsList = Products().customerProducts(id);
    _customerProducts = await customerProductsList;
    notifyListeners();
  }
}
