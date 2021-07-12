import 'package:flutter/widgets.dart';

import 'package:ta2set_app/models/supplier.dart';

class SupplierProvider with ChangeNotifier {
  List<Supplier> _suppliers = [];

  List<Supplier> get allSupplier {
    return [..._suppliers];
  }

  void addSupplier(String name, String phone1, String phone2, String address) {
    _suppliers.add(
      Supplier(name: name, phone1: phone1, phone2: phone2, address: address),
    );
    Supplier().addsublayer(name, phone1, phone2, address);
    notifyListeners();
  }

  Future<void> fetchAndSetSupplier() async {
    final dataList = Supplier().viewsublayers();
    _suppliers = await dataList;

    notifyListeners();
  }

  void editCustomer(
      int id, String name, String phone1, String phone2, String address) {
    Supplier().editsublayer(id, name, phone1, phone2, address);
    notifyListeners();
  }

  Future<Supplier> getSupplierById(int id) async {
    var e = await Supplier().getcustomerbyid(id);
    notifyListeners();
    return e;
  }

  Future<Supplier> getSupplierByPhone(String phone) async {
    var e = await Supplier().getsuplayerbyphone(phone);
    notifyListeners();
    return e;
  }

  void deleteSupplier(int id) {
    _suppliers.removeAt(id);
    notifyListeners();
  }

  void deleteAllSuppliers() {
    _suppliers.clear();
    notifyListeners();
  }
}
