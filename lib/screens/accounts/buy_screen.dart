import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:ta2set_app/models/products.dart';

import 'package:ta2set_app/providers/supplier_provider.dart';
import 'package:toast/toast.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key key}) : super(key: key);

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  final formKey = GlobalKey<FormState>();

  // String _dateFormat = '';
  // DateTime _datetime;
  int _supplierID;
  String _itemPrice = '', _descrptionText = '';
  @override
  Widget build(BuildContext context) {
    final supplierData = Provider.of<SupplierProvider>(context, listen: false);

    final _amountFocusNode = FocusNode();
    final _installmentFocusNode = FocusNode();
    final _descriptionFocusNode = FocusNode();

    void submit() {
      final form = formKey.currentState;

      if (form.validate() && _supplierID != null) {
        form.save();
        Products().addproduct(
          buying_price: double.parse(_itemPrice),
          name: _descrptionText,
          sublayer: _supplierID,
        );
        print(_itemPrice);
        print(_descrptionText);
        //  print(_dateFormat);
        print(_supplierID.toString());
        Toast.show(
          "!تم أضافة عملية الشراء بنجاح",
          context,
          duration: 2,
          gravity: Toast.CENTER,
        );
        form.reset();
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<SupplierProvider>(context, listen: false)
              .fetchAndSetSupplier(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: <Widget>[
                        TabBarWidget(
                          tabName: "عملية شراء",
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .3,
                            child: Form(
                                key: formKey,
                                child: ListView(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: SearchableDropdown.single(
                                                key: Key("1"),
                                                items: supplierData.allSupplier
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                          value: e.id,
                                                          child: Text(e.name),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _supplierID = value;
                                                  });
                                                },
                                                isExpanded: true,
                                                value: _supplierID,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .05,
                                            child: FittedBox(
                                              child: Text(
                                                ': اختار المورد',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            child: Container(
                                              /* =================  البضاعة ===============================
                    =========================================================*/
                                              child: TextFormField(
                                                style: TextStyle(
                                                  fontFamily: "Cairo",
                                                ),
                                                focusNode:
                                                    _descriptionFocusNode,
                                                keyboardType:
                                                    TextInputType.name,
                                                decoration: InputDecoration(
                                                  errorStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 15,
                                                          bottom: 11,
                                                          top: 11,
                                                          right: 15),
                                                ),
                                                validator: (value) {
                                                  if (value != null &&
                                                      value.length < 2) {
                                                    return "بالرجاء أدخال اسم البضاعة";
                                                  } else
                                                    return null;
                                                },
                                                onSaved: (value) =>
                                                    _descrptionText = value,
                                                onFieldSubmitted: (_) {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _amountFocusNode);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .05,
                                          child: FittedBox(
                                            child: Text(
                                              ': البضاعة',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            child: Container(
                                              /* =================  المبلغ ===============================
                    =========================================================*/
                                              child: TextFormField(
                                                style: TextStyle(
                                                  fontFamily: "Cairo",
                                                ),
                                                focusNode: _amountFocusNode,
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration: InputDecoration(
                                                  errorStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 15,
                                                          bottom: 11,
                                                          top: 11,
                                                          right: 15),
                                                ),
                                                validator: (value) => value ==
                                                            null ||
                                                        value.length < 1
                                                    ? "بالرجاء أدخال سعر البضاعة "
                                                    : null,
                                                onSaved: (value) =>
                                                    _itemPrice = value,
                                                onFieldSubmitted: (_) {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _installmentFocusNode);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .05,
                                          child: FittedBox(
                                            child: Text(
                                              ': المبلغ',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    //     Row(
                                    //       children: <Widget>[
                                    //         Expanded(
                                    //           child: Text(
                                    //             _dateFormat == ''
                                    //                 ? "لم يتم أختيار التاريخ بعد"
                                    //                 : _dateFormat,
                                    //             style: TextStyle(
                                    //               color: Colors.white,
                                    //               fontWeight: FontWeight.bold,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         SizedBox(
                                    //           width: 20,
                                    //         ),
                                    //         Container(
                                    //             width: MediaQuery.of(context).size.width * 0.1,

                                    //             /* =================  التسديد ===============================
                                    // =========================================================*/
                                    //             child: ElevatedButton(
                                    //               focusNode: _installmentFocusNode,
                                    //               onPressed: () {
                                    //                 showDatePicker(
                                    //                   context: context,
                                    //                   initialDate: DateTime.now(),
                                    //                   firstDate: DateTime(2000),
                                    //                   lastDate: DateTime(2100),
                                    //                 ).then((date) {
                                    //                   if (date == null) {
                                    //                     return;
                                    //                   }
                                    //                   setState(() {
                                    //                     _datetime = date;
                                    //                     _dateFormat = DateFormat("yyyy-MM-dd")
                                    //                         .format(_datetime);
                                    //                   });
                                    //                 });
                                    //               },
                                    //               child: FittedBox(
                                    //                 child: Text(
                                    //                   'أختار التاريخ',
                                    //                   style: TextStyle(
                                    //                     color: Colors.blue[900],
                                    //                     fontWeight: FontWeight.bold,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               style: ButtonStyle(
                                    //                   backgroundColor:
                                    //                       MaterialStateProperty.all(
                                    //                           Colors.white)),
                                    //             )),
                                    //         SizedBox(
                                    //           width: 20,
                                    //         ),
                                    //         Container(
                                    //           width: MediaQuery.of(context).size.width * .05,
                                    //           child: FittedBox(
                                    //             child: Text(
                                    //               ': ميعاد التسديد',
                                    //               style: TextStyle(
                                    //                   color: Colors.white,
                                    //                   fontWeight: FontWeight.bold),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     SizedBox(
                                    //       height: 30,
                                    //     ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .1,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .1),
                                      child: ElevatedButton(
                                        child: FittedBox(
                                          child: Text(
                                            "تم",
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        onPressed: submit,
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Colors.blue[900],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
