import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:ta2set_app/models/sell.dart';
import 'package:ta2set_app/providers/customer_provider.dart';
import 'package:ta2set_app/providers/products_provider.dart';
import 'package:toast/toast.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final formKey = GlobalKey<FormState>();
  var totalController = new TextEditingController();
  var downPaymentController = new TextEditingController();
  var installmentController = new TextEditingController();
  var installmentNOController = new TextEditingController();

  String _dateFormat = '';
  DateTime _datetime;
  var _selectedTime = 'يومي';
  // ignore: non_constant_identifier_names
  int _customer_id;

  // ignore: non_constant_identifier_names
  int _product_id;
  double _total;
  double _downpayment;
  // ignore: non_constant_identifier_names
  int _no_of_installments;
  // ignore: non_constant_identifier_names
  double _value_of_installment;
  int _period;

  @override
  Widget build(BuildContext context) {
    final customerData = Provider.of<CustomerProvider>(context, listen: false);
    final productData = Provider.of<ProductsProvider>(context, listen: false);
    var timeList = ["يومي", "اسبوعي", "شهري", "سنوي"];

    final _amountFocusNode = FocusNode();
    final _installmentFocusNode = FocusNode();
    final _buttonFocusNode = FocusNode();

    final _downPaymentFocusNode = FocusNode();
    final _valueOfInstallmentFocusNode = FocusNode();
    final _numOfInstallmentFocusNode = FocusNode();
    final _typeOfInstallmentFocusNode = FocusNode();

    void submit() {
      final form = formKey.currentState;
      if (_selectedTime == "يومي") {
        _period = 0;
      } else if (_selectedTime == "اسبوعي") {
        _period = 1;
      } else if (_selectedTime == "شهري") {
        _period = 2;
      } else if (_selectedTime == "سنوي") {
        _period = 3;
      }
      print(_customer_id);

      if (form.validate() &&
          _customer_id != null &&
          _product_id != null &&
          _dateFormat != null &&
          _dateFormat != '') {
        form.save();
        Sell().sell(
          customer_id: _customer_id, //done
          downpayment: _downpayment, //done
          no_of_installments: _no_of_installments, //done
          period: _period, //done
          product_id: _product_id, //done
          startdate: _dateFormat, //done
          total: _total, //done
          value_of_installment: _value_of_installment, //done
        );

        form.reset();
        setState(() {
          totalController.text = "";
          downPaymentController.text = "";
          installmentController.text = "";
          installmentNOController.text = "";
        });
        Toast.show(
          "!تم أضافة عملية البيع بنجاح",
          context,
          duration: 2,
          gravity: Toast.CENTER,
        );
      }
    }

    installmentCost() {
      if (installmentNOController.text == "" ||
          installmentNOController == null) {
        double priceCost = 0.0;
        installmentController.text = priceCost.toString();
      }
      double priceCost = (double.parse(totalController.text) -
              double.parse(downPaymentController.text)) /
          double.parse(installmentNOController.text);
      installmentController.text = priceCost.toStringAsFixed(1);
    }

    numberInstallment() {
      if (installmentController.text == "" ||
          installmentController.text == null) {
        int numInstallment = 0;
        installmentController.text = numInstallment.toString();
      }
      double numInstallment = (double.parse(totalController.text) -
              double.parse(downPaymentController.text)) /
          double.parse(installmentController.text);

      installmentNOController.text = (numInstallment.ceil()).toString();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TabBarWidget(
              tabName: "عملية بيع",
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
                        FutureBuilder(
                          future: customerData.fetchAndSetCustomer(),
                          builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) =>
                              snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: SearchableDropdown.single(
                                                key: Key("1"),
                                                items: customerData.allCustomer
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                          value: e.id,
                                                          child: Text(e.name),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _customer_id = value;
                                                  });
                                                  print(_customer_id);
                                                },
                                                isExpanded: true,
                                                value: _customer_id,
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
                                                ': اختار العميل',
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
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FutureBuilder(
                          future: productData.fetchAndSetProducts(),
                          builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) =>
                              snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: SearchableDropdown.single(
                                                key: Key("2"),
                                                items: productData.allProducts
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                          value: e.id,
                                                          child: Text(e.name),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _product_id = value;
                                                  });
                                                  print(_product_id);
                                                },
                                                isExpanded: true,
                                                value: _product_id,
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
                                                ': اختار المنتج',
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
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Container(
                                  /* =================   المبلغ  الكلي ===============================
                    =========================================================*/
                                  child: TextFormField(
                                    controller: totalController,
                                    style: TextStyle(
                                      fontFamily: "Cairo",
                                    ),
                                    focusNode: _amountFocusNode,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      disabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                    ),
                                    validator: (value) =>
                                        value == null || value.length < 1
                                            ? "بالرجاء أدخال سعر المنتج "
                                            : null,
                                    onSaved: (value) =>
                                        _total = double.parse(value),
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_installmentFocusNode);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .05,
                              child: FittedBox(
                                child: Text(
                                  ': المبلغ الكلي',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Container(
                                  /* =================  المقدم ===============================
                    =========================================================*/
                                  child: TextFormField(
                                    controller: downPaymentController,
                                    style: TextStyle(
                                      fontFamily: "Cairo",
                                    ),
                                    focusNode: _downPaymentFocusNode,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      disabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                    ),
                                    validator: (value) =>
                                        value == null || value.length < 1
                                            ? "بالرجاء أدخال المقدم "
                                            : null,
                                    onSaved: (value) =>
                                        _downpayment = double.parse(value),
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context).requestFocus(
                                          _valueOfInstallmentFocusNode);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .05,
                              child: FittedBox(
                                child: Text(
                                  ': المقدم',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Container(
                                  /* =================  سعر القسط ===============================
                    =========================================================*/
                                  child: TextFormField(
                                    controller: installmentController,
                                    onChanged: (text) {
                                      numberInstallment();
                                    },
                                    style: TextStyle(
                                      fontFamily: "Cairo",
                                    ),
                                    focusNode: _valueOfInstallmentFocusNode,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      disabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                    ),
                                    validator: (value) =>
                                        value == null || value.length < 1
                                            ? "بالرجاء أدخال سعر القسط "
                                            : null,
                                    onSaved: (value) => _value_of_installment =
                                        double.parse(value),
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context).requestFocus(
                                          _numOfInstallmentFocusNode);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .05,
                              child: FittedBox(
                                child: Text(
                                  ': سعر القسط',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                /* ================= عدد الأقساط ===============================
                    =========================================================*/
                                child: TextFormField(
                                  onChanged: (text) {
                                    installmentCost();
                                  },
                                  controller: installmentNOController,
                                  style: TextStyle(
                                    fontFamily: "Cairo",
                                  ),
                                  focusNode: _numOfInstallmentFocusNode,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    disabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  validator: (value) =>
                                      value == null || value.length < 1
                                          ? "بالرجاء أدخال عدد الأقساط "
                                          : null,
                                  onSaved: (value) =>
                                      _no_of_installments = int.parse(value),
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(
                                        _typeOfInstallmentFocusNode);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .05,
                              child: FittedBox(
                                child: Text(
                                  ': عدد الاقساط',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: null,
                              ),
                            ),
                            /* =================  المدة ===============================
                    =========================================================*/
                            Container(
                              color: Colors.white,
                              child: DropdownButton<String>(
                                items: timeList.map((String dropItem) {
                                  return DropdownMenuItem(
                                    value: dropItem,
                                    child: Text(dropItem),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedTime = newValue;
                                  });
                                },
                                value: _selectedTime,
                                focusNode: _buttonFocusNode,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .05,
                              child: FittedBox(
                                child: Text(
                                  ':مدة القسط',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _dateFormat == ''
                                    ? "لم يتم أختيار التاريخ بعد"
                                    : _dateFormat,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.1,

                                /* =================  التسديد ===============================
                    =========================================================*/
                                child: ElevatedButton(
                                  focusNode: _installmentFocusNode,
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    ).then((date) {
                                      if (date == null) {
                                        return;
                                      }
                                      setState(() {
                                        _datetime = date;
                                        _dateFormat = DateFormat("yyyy-MM-dd")
                                            .format(_datetime);
                                      });
                                    });
                                  },
                                  child: FittedBox(
                                    child: Text(
                                      'أختار التاريخ',
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .05,
                              child: FittedBox(
                                child: Text(
                                  ':تاريخ البيع ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .1,
                              right: MediaQuery.of(context).size.width * .1),
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
                                borderRadius: BorderRadius.circular(32.0),
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
    );
  }
}
