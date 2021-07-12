import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:ta2set_app/providers/customer_provider.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:ta2set_app/providers/products_provider.dart';
import 'package:ta2set_app/screens/customer/product_installment.dart';

class CustomerInfoScreen extends StatefulWidget {
  final String name;
  final String phoneNumber1;
  final String phoneNumber2;

  final int id;

  const CustomerInfoScreen({
    Key key,
    this.name,
    this.phoneNumber1,
    this.phoneNumber2,
    this.id,
  }) : super(key: key);

  @override
  _CustomerInfoScreenState createState() => _CustomerInfoScreenState();
}

class _CustomerInfoScreenState extends State<CustomerInfoScreen> {
  ScrollController _controller = ScrollController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phone1Controller = TextEditingController();
  TextEditingController _phone2Controller = TextEditingController();
  var nameString = '';
  var phoneString = "";
  var phone2String = '';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context, listen: false);
    final customerData = Provider.of<CustomerProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: DraggableScrollbar.rrect(
            scrollbarTimeToFade: const Duration(milliseconds: 1500),
            controller: _controller,
            child: ListView(
              controller: _controller,
              children: <Widget>[
                TabBarWidget(
                  tabName: "بيانات العميل",
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0)), //this right here
                                child: Container(
                                  height: 500,
                                  width: 500,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'تعديل البيانات',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue[900]),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              labelText: 'اسم العميل',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: _phone1Controller,
                                            decoration: InputDecoration(
                                                labelText: 'رقم الهاتف 1'),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: _phone2Controller,
                                            decoration: InputDecoration(
                                                labelText: 'رقم الهاتف 2'),
                                          ),
                                        ),
                                        SizedBox(
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue[900]),
                                            ),
                                            onPressed: () {
                                              if (_nameController.text ==
                                                      null ||
                                                  _nameController.text == "") {
                                                nameString = widget.name;
                                              } else {
                                                nameString =
                                                    _nameController.text;
                                              }
                                              //==========================================
                                              if (_phone1Controller.text ==
                                                      null ||
                                                  _phone1Controller.text ==
                                                      "") {
                                                phoneString =
                                                    widget.phoneNumber1;
                                              } else {
                                                phoneString =
                                                    _phone1Controller.text;
                                              }
                                              //==========================================
                                              if (_phone2Controller.text ==
                                                      null ||
                                                  _phone2Controller.text ==
                                                      "") {
                                                phone2String =
                                                    widget.phoneNumber2;
                                              } else {
                                                phone2String =
                                                    _phone2Controller.text;
                                              }
                                              //==========================================
                                              customerData.editCustomer(
                                                widget.id,
                                                nameString,
                                                phoneString,
                                                phone2String,
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "حفظ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: FittedBox(
                        child: Text(
                          'تعديل البيانات',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .02,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2)),
                      height: MediaQuery.of(context).size.height * .35,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Column(
                        children: [
                          Expanded(
                            child: InfoRaw(
                              text1: widget.id.toString(),
                              text2: "  ID :",
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: InfoRaw(
                              text1: widget.name,
                              text2: "  الأسم :",
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: InfoRaw(
                              text1: widget.phoneNumber1.toString(),
                              text2: "  رقم الهاتف 1 :",
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: InfoRaw(
                              text1: widget.phoneNumber2,
                              text2: "  رقم الهاتف 2 :",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .15,
                    child: FittedBox(
                      child: Text(
                        'كشف حساب',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                      child: FutureBuilder(
                    future: productsData.customerProducts(widget.id),
                    builder: (context, snapshot) => snapshot.connectionState ==
                            ConnectionState.waiting
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : DataTable(
                            dividerThickness: 2,
                            horizontalMargin: 40,
                            columns: [
                              DataColumn(
                                label: Text(
                                  'التاريخ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                numeric: true,
                                label: Text(
                                  'المبلغ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'المنتج',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                numeric: true,
                                label: Text(
                                  'رقم العملية',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: productsData.allCutsomerProducts
                                .map((e) => DataRow(
                                        onSelectChanged: (selected) {
                                          if (selected) {
                                            return Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductInstallmentsScreen(
                                                            saleID: e.saleID)));
                                          }
                                        },
                                        cells: [
                                          DataCell(
                                            Text(
                                              e.date,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              e.selling_price.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              e.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              e.id.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]))
                                .toList()),
                  )),
                )
              ],
            ),
          ),
        ));
  }
}

class InfoRaw extends StatelessWidget {
  final String text1;
  final String text2;
  const InfoRaw({Key key, this.text1, this.text2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text(
              text1,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 25),
            child: Text(
              text2,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
