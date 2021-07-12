import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:ta2set_app/providers/products_provider.dart';
import 'package:ta2set_app/screens/products/product_info_screen.dart';

class AllCustomersScreen extends StatelessWidget {
  const AllCustomersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prodcutData = Provider.of<ProductsProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Stack(children: [
        Column(
          children: <Widget>[
            TabBarWidget(
              tabName: "جميع البضائع",
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
                      future: prodcutData.fetchAndSetProducts(),
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
                                        'تاريخ الشراء',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'سعر الشراء',
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
                                        'اسم البضاعة',
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
                                  rows: prodcutData.allProducts
                                      .map(
                                        (e) => DataRow(
                                          onSelectChanged: (selected) {
                                            if (selected) {
                                              return Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductInfoScreen(
                                                            productID: e.id,
                                                            customerID:
                                                                e.customer,
                                                            supplyierID:
                                                                e.sublayer,
                                                            name: e.name,
                                                            date: e.date,
                                                            buyingPrice:
                                                                e.buying_price,
                                                            sellingPrice:
                                                                e.selling_price,
                                                          )));
                                            }
                                          },
                                          cells: [
                                            DataCell(
                                              Text(
                                                e.date,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                e.buying_price.toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                e.sublayer.toString(),
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
