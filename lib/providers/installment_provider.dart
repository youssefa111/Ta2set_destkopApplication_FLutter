import 'package:flutter/cupertino.dart';
import 'package:ta2set_app/models/Installments.dart';
import 'package:ta2set_app/models/admin.dart';

class InstallmentProvider with ChangeNotifier {
  List<Installments> _productInsallment = [
    Installments(),
  ];

  List<Installments> get productInstallments {
    return [..._productInsallment];
  }

  Future<void> productInstallmentsInfo(int saleID) async {
    var productInstallmentsInfoList =
        await Installments().productInstallments(saleID);
    _productInsallment = productInstallmentsInfoList;
    notifyListeners();
  }

  Future<void> payFunction(int instID, double value) async {
    await Admin().collect(instID, value);
    notifyListeners();
  }
}
