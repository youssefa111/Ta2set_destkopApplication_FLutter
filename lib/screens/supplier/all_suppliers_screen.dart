import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:ta2set_app/providers/supplier_provider.dart';
import 'package:toast/toast.dart';

import 'supplier_info_screen.dart';

class AllSuppliersScreen extends StatelessWidget {
  const AllSuppliersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final supplierData = Provider.of<SupplierProvider>(context, listen: false);
    var idController = TextEditingController();
    var phoneController = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Stack(children: [
        Column(
          children: <Widget>[
            TabBarWidget(
              tabName: "جميع الموردين",
            ),
            SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(
                    ': ID البحث بال',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    height: 40,
                    width: 100,
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: idController,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () async {
                      var e = await supplierData
                          .getSupplierById(int.parse(idController.text));
                      if (e.id != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SupplierInfoScreen(
                                  id: e.id,
                                  name: e.name,
                                  phoneNumber1: e.phone1,
                                  phoneNumber2: e.phone2,
                                  address: e.address,
                                )));
                      } else {
                        Toast.show(
                          " ID لا يوجد مورد بهذا ال",
                          context,
                          duration: 1,
                          gravity: Toast.TOP,
                        );
                      }
                    },
                    child: Text(
                      'بحث',
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Text(
                    ': البحث برقم الهاتف',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    height: 40,
                    width: 150,
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: phoneController,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () async {
                      var e = await supplierData
                          .getSupplierByPhone(phoneController.text);
                      if (e.phone1 != null || e.phone2 != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SupplierInfoScreen(
                                  id: e.id,
                                  name: e.name,
                                  phoneNumber1: e.phone1,
                                  phoneNumber2: e.phone2,
                                  address: e.address,
                                )));
                      } else {
                        Toast.show(
                          "لا يوجد مورد بهذا رقم الهاتف",
                          context,
                          duration: 1,
                          gravity: Toast.TOP,
                        );
                      }
                    },
                    child: Text(
                      'بحث',
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView(children: [
                  SingleChildScrollView(
                    reverse: true,
                    child: FutureBuilder(
                      future: supplierData.fetchAndSetSupplier(),
                      builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : DataTable(
                                  horizontalMargin: 20,
                                  dividerThickness: 2,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        'العنوان',
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'رقم الهاتف 2',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'رقم الهاتف 1',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'اسم المورد',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'ID',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                  rows: supplierData.allSupplier
                                      .map(
                                        (e) => DataRow(
                                          onSelectChanged: (selected) {
                                            if (selected) {
                                              return Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SupplierInfoScreen(
                                                            id: e.id,
                                                            name: e.name,
                                                            phoneNumber1:
                                                                e.phone1,
                                                            phoneNumber2:
                                                                e.phone2,
                                                            address: e.address,
                                                          )));
                                            }
                                          },
                                          cells: [
                                            DataCell(
                                              Text(
                                                e.address,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                e.phone2,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                e.phone1,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                e.name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                e.id.toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ])),
    );
  }
}
