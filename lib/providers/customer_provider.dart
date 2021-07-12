import 'package:flutter/widgets.dart';

import 'package:ta2set_app/models/customer.dart';

class CustomerProvider with ChangeNotifier {
  List<Customer> _customers = [];

  List<Customer> get allCustomer {
    return [..._customers];
  }

  void addCustomer(String name, String phone1, String phone2) {
    _customers.add(
      Customer(
        name: name,
        phone1: phone1,
        phone2: phone2,
      ),
    );
    Customer().addcustomer(name, phone1, phone2);
    notifyListeners();
  }

  Future<void> fetchAndSetCustomer() async {
    final dataList = Customer().viewcustomers();
    _customers = await dataList;
    notifyListeners();
  }

  void editCustomer(int id, String name, String phone1, String phone2) {
    Customer().editcustomer(id, name, phone1, phone2);
    notifyListeners();
  }

  Future<Customer> getCustomerById(int id) async {
    var e = await Customer().getcustomerbyid(id);

    notifyListeners();
    return e;
  }

  Future<Customer> getCustomerByPhone(String phone) async {
    var e = await Customer().getcustomerbyphone(phone);
    notifyListeners();
    return e;
  }

  void deleteCustomer(int id) {
    _customers.removeAt(id);
    notifyListeners();
  }

  void deleteAllCustomer() {
    _customers.clear();
    notifyListeners();
  }
}
