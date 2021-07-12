import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';

import 'package:ta2set_app/providers/customer_provider.dart';

import 'package:toast/toast.dart';

class AddCustomerScreen extends StatefulWidget {
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String name = '';
    String phone1 = '';
    String phone2 = '';
    final _nameFocusNode = FocusNode();
    final _phone1FocusNode = FocusNode();
    final _phone2FocusNode = FocusNode();
    final customerData = Provider.of<CustomerProvider>(context, listen: false);
    void submit() {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        customerData.addCustomer(name, phone1, phone2);
        Toast.show(
          "!تم أضافة العميل بنجاح",
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
          child: Column(
            children: <Widget>[
              TabBarWidget(
                tabName: "أضافة عميل",
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * .3,
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 35),
                              child: Text(
                                'اسم العميل',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                onEditingComplete: () {
                                  submit();
                                },
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                ),
                                textDirection: TextDirection.rtl,
                                focusNode: _nameFocusNode,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                ),
                                validator: (value) {
                                  if (value != null && value.length < 2) {
                                    return "بالرجاء أدخال اسم العميل و يكون اكثر من حرفين";
                                  } else
                                    return null;
                                },
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_phone1FocusNode);
                                },
                                onSaved: (value) => name = value,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 35),
                              child: Text(
                                '1 رقم الهاتف',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                onEditingComplete: () {
                                  submit();
                                },
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                ),
                                focusNode: _phone1FocusNode,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                ),
                                validator: (value) => value == null ||
                                        value == ""
                                    ? "بالرجاء أدخال رقم الهاتف بطريقة صحيحة "
                                    : null,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_phone2FocusNode);
                                },
                                onSaved: (value) => phone1 = value,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 35),
                              child: Text(
                                '2 رقم الهاتف',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                onEditingComplete: () {
                                  submit();
                                },
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                ),
                                focusNode: _phone2FocusNode,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                ),
                                validator: (value) => value == null ||
                                        value == ""
                                    ? "بالرجاء أدخال رقم الهاتف بطريقة صحيحة "
                                    : null,
                                onSaved: (value) => phone2 = value,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .1,
                              right: MediaQuery.of(context).size.width * .1),
                          child: ElevatedButton(
                            child: FittedBox(
                              child: Text(
                                "أضف",
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
