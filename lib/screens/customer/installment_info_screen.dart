import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:ta2set_app/providers/installment_provider.dart';
import 'package:toast/toast.dart';

class InstallmentInfoScreen extends StatefulWidget {
  const InstallmentInfoScreen({
    Key key,
    // ignore: non_constant_identifier_names
    this.customer_id,
    // ignore: non_constant_identifier_names
    this.inst_id,
    // ignore: non_constant_identifier_names
    this.sale_id,
    // ignore: non_constant_identifier_names
    this.inst_real_value,
    // ignore: non_constant_identifier_names
    this.payed_value,
    // ignore: non_constant_identifier_names
    this.real_date,
    // ignore: non_constant_identifier_names
    this.payed_date,
    this.payed,
  }) : super(key: key);
  // ignore: non_constant_identifier_names
  final int customer_id;
  // ignore: non_constant_identifier_names
  final int inst_id;
  // ignore: non_constant_identifier_names
  final int sale_id;
  // ignore: non_constant_identifier_names
  final double inst_real_value;
  // ignore: non_constant_identifier_names
  final double payed_value;
  // ignore: non_constant_identifier_names
  final String real_date;
  // ignore: non_constant_identifier_names
  final String payed_date;
  final int payed;

  @override
  _InstallmentInfoScreenState createState() => _InstallmentInfoScreenState();
}

class _InstallmentInfoScreenState extends State<InstallmentInfoScreen> {
  final TextEditingController _textEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final installmentData =
        Provider.of<InstallmentProvider>(context, listen: false);
    TextStyle textStyle = TextStyle(
        color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 20);

    Future<void> submit() async {
      await installmentData.payFunction(
          widget.inst_id, double.parse(_textEditingController.text));

      Toast.show(
        "!تم أضافة المبلغ بنجاح",
        context,
        duration: 1,
        gravity: Toast.CENTER,
      );
      Future.delayed(Duration(milliseconds: 1500))
          .then((value) => Navigator.pop(context));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          TabBarWidget(tabName: "بيانات المنتج"),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  children: [
                    Expanded(
                        child: DataRowInfo(
                      dataInfo: widget.inst_id.toString(),
                      dataHead: "أسم المنتج   :",
                    )),
                    Expanded(
                        child: DataRowInfo(
                      dataInfo: widget.real_date,
                      dataHead: "تاريخ تحصيل القسط   :",
                    )),
                    Expanded(
                        child: DataRowInfo(
                      dataInfo: widget.inst_real_value.toString(),
                      dataHead: "مبلغ القسط   :",
                    )),
                    Expanded(
                        child: DataRowInfo(
                      dataInfo: widget.inst_real_value.toString(),
                      dataHead: "اجمالى المبلغ المتبقى من هذا المنتج   :",
                    )),
                    Expanded(
                        child: DataRowInfo(
                      dataInfo: widget.inst_real_value.toString(),
                      dataHead: "اجمالى المبلغ المتبقى على العميل   :",
                    )),
                    Expanded(
                        child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .07,
                        ),
                        Expanded(
                            child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                          ),
                        )),
                        Expanded(
                            child: Text(
                          "ادخل المبلغ   :",
                          style: textStyle,
                          textDirection: TextDirection.rtl,
                        )),
                        SizedBox(
                          width: 25,
                        ),
                      ],
                    )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .1,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(18),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[900]),
                        ),
                        onPressed: submit,
                        child: Text(
                          'تسجيل',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataRowInfo extends StatelessWidget {
  const DataRowInfo({Key key, this.dataInfo, this.dataHead}) : super(key: key);
  final String dataInfo;
  final String dataHead;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 20);
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * .07,
        ),
        Expanded(
            child: Text(
          dataInfo,
          style: textStyle,
        )),
        Expanded(
            child: Text(
          dataHead,
          style: textStyle,
          textDirection: TextDirection.rtl,
        )),
        SizedBox(
          width: 25,
        ),
      ],
    );
  }
}
