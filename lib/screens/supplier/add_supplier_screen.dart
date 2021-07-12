import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:ta2set_app/providers/supplier_provider.dart';
import 'package:toast/toast.dart';

class AddSupplierScreen extends StatefulWidget {
  @override
  _AddSupplierScreenState createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String name = '';
    String phone1 = '';
    String phone2 = '';
    String address = '';
    final supplierData = Provider.of<SupplierProvider>(context, listen: false);
    void submit() {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        supplierData.addSupplier(name, phone1, phone2, address);
        Toast.show(
          "!تم أضافة المورد بنجاح",
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
                tabName: "أضافة مورد",
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
                                'اسم المورد',
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
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      fontFamily: 'Cairo',
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
                                    return "بالرجاء أدخال اسم المورد و يكون اكثر من حرفين";
                                  } else
                                    return null;
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 35),
                              child: Text(
                                'العنوان',
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
                                validator: (value) =>
                                    value != null && value.length < 2
                                        ? "بالرجاء أدخال العنوان  "
                                        : null,
                                onSaved: (value) {
                                  address = value;
                                },
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
