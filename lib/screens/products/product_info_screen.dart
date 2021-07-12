import 'package:flutter/material.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class ProductInfoScreen extends StatefulWidget {
  final String name;
  final String date;
  final double buyingPrice;
  final double sellingPrice;
  final int supplyierID;
  final int customerID;
  final int productID;

  const ProductInfoScreen({
    Key key,
    this.name,
    this.date,
    this.productID,
    this.supplyierID,
    this.customerID,
    this.buyingPrice,
    this.sellingPrice,
  }) : super(key: key);

  @override
  _ProductInfoScreenState createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<ProductProvider>(context, listen: false);
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
                  tabName: "بيانات المنتج",
                ),
                SizedBox(
                  height: 45,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2)),
                    height: MediaQuery.of(context).size.height * .35,
                    width: MediaQuery.of(context).size.width * .7,
                    child: Column(
                      children: [
                        Expanded(
                          child: InfoRaw(
                            text1: widget.productID.toString(),
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
                            text1: widget.date.toString(),
                            text2: "  تاريخ الشراء :",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: InfoRaw(
                            text1: widget.buyingPrice.toString(),
                            text2: "  سعر الشراء :",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: InfoRaw(
                            text1: widget.supplyierID.toString(),
                            text2: "  المورد :",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .15,
                    child: FittedBox(
                      child: Text(
                        'كشف العملاء',
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
                    child: DataTable(
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
                              'ملحوظة',
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
                        rows: []
                        // productData.allProducts
                        //     .where((element) => element.customerID == widget.id)
                        //     .toList()
                        //     .map((e) => DataRow(
                        //             onSelectChanged: (selected) {
                        //               if (selected) {
                        //                 return Navigator.of(context).push(
                        //                     MaterialPageRoute(
                        //                         builder: (context) =>
                        //                             CustomerProductInfoScreen(
                        //                               productName:
                        //                                   e.productName,
                        //                               installmentDate:
                        //                                   e.buyDate,
                        //                               installmentAmount:
                        //                                   e.installmentCost,
                        //                               remainingTotalCost:
                        //                                   e.installmentCost,
                        //                               remainingCustomerCost:
                        //                                   e.installmentCost,
                        //                             )));
                        //               }
                        //             },
                        //             cells: [
                        //               DataCell(
                        //                 Text(
                        //                   e.buyDate,
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //               DataCell(
                        //                 Text(
                        //                   e.installmentCost.toString(),
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //               DataCell(
                        //                 Text(
                        //                   e.productName,
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //               DataCell(
                        //                 Text(
                        //                   e.productID.toString(),
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               )
                        //             ]))
                        //     .toList(),
                        ),
                  ),
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
        Container(
          width: MediaQuery.of(context).size.width * .3,
          child: Text(
            text1,
            textDirection: TextDirection.rtl,
            style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .3,
          child: Text(
            text2,
            textDirection: TextDirection.rtl,
            style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ],
    );
  }
}
