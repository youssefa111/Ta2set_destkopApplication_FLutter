import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:ta2set_app/providers/installment_provider.dart';

import 'installment_info_screen.dart';

class ProductInstallmentsScreen extends StatefulWidget {
  const ProductInstallmentsScreen({Key key, this.saleID}) : super(key: key);
  final int saleID;

  @override
  _ProductInstallmentsScreenState createState() =>
      _ProductInstallmentsScreenState();
}

class _ProductInstallmentsScreenState extends State<ProductInstallmentsScreen> {
  @override
  Widget build(BuildContext context) {
    final installmentData =
        Provider.of<InstallmentProvider>(context, listen: false);
    ScrollController _controller = ScrollController();
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: DraggableScrollbar.rrect(
            scrollbarTimeToFade: const Duration(milliseconds: 1500),
            controller: _controller,
            child: ListView(
              controller: _controller,
              children: <Widget>[
                TabBarWidget(tabName: "بيانات المنتج"),
                SizedBox(
                  height: 45,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                      child: FutureBuilder(
                    future:
                        Provider.of<InstallmentProvider>(context, listen: false)
                            .productInstallmentsInfo(widget.saleID),
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
                                  'تاريخ القسط',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'تاريخ الدفع',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                numeric: true,
                                label: Text(
                                  'قيمة الدفع',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'سعر القسط',
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
                            rows: installmentData.productInstallments
                                .map((e) => DataRow(
                                        onSelectChanged: (selected) {
                                          if (selected) {
                                            return Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InstallmentInfoScreen(
                                                          customer_id:
                                                              e.customer_id,
                                                          inst_id: e.inst_id,
                                                          inst_real_value:
                                                              e.inst_real_value,
                                                          payed: e.payed,
                                                          payed_date:
                                                              e.payed_date,
                                                          payed_value:
                                                              e.payed_value,
                                                          real_date:
                                                              e.real_date,
                                                          sale_id: e.sale_id,
                                                        )));
                                          }
                                        },
                                        cells: [
                                          DataCell(
                                            Text(
                                              e.real_date,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              e.payed_date == null
                                                  ? "لم يتم الدفع حتي الأن"
                                                  : e.payed_date,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              e.payed_value == 0
                                                  ? "لم يتم الدفع حتي الأن"
                                                  : e.payed_value.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              e.inst_real_value.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              e.inst_id.toString(),
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
