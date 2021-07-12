import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:ta2set_app/providers/customer_provider.dart';
import 'package:ta2set_app/screens/customer/customer_info_screen.dart';
import 'package:toast/toast.dart';

class AllCustomersScreen extends StatelessWidget {
  const AllCustomersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customerData = Provider.of<CustomerProvider>(context, listen: false);
    var idController = TextEditingController();
    var phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Stack(children: [
        Column(
          children: <Widget>[
            TabBarWidget(
              tabName: "جميع العملاء",
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
                      var e = await customerData
                          .getCustomerById(int.parse(idController.text));
                      if (e.id != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CustomerInfoScreen(
                                  id: e.id,
                                  name: e.name,
                                  phoneNumber1: e.phone1,
                                  phoneNumber2: e.phone2,
                                )));
                      } else {
                        Toast.show(
                          " ID لا يوجد عميل بهذا ال",
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
                      var e = await customerData
                          .getCustomerByPhone(phoneController.text);
                      if (e.phone1 != null || e.phone2 != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CustomerInfoScreen(
                                  id: e.id,
                                  name: e.name,
                                  phoneNumber1: e.phone1,
                                  phoneNumber2: e.phone2,
                                )));
                      } else {
                        Toast.show(
                          "لا يوجد عميل بهذا رقم الهاتف",
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
                      future: customerData.fetchAndSetCustomer(),
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
                                        'اسم العميل',
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
                                  rows: customerData.allCustomer
                                      .map(
                                        (e) => DataRow(
                                          onSelectChanged: (selected) {
                                            if (selected) {
                                              return Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CustomerInfoScreen(
                                                            id: e.id,
                                                            name: e.name,
                                                            phoneNumber1:
                                                                e.phone1,
                                                            phoneNumber2:
                                                                e.phone2,
                                                          )));
                                            }
                                          },
                                          cells: [
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
