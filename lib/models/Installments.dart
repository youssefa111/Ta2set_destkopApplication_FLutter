import 'package:ta2set_app/helpers/db_helpers.dart';

class Installments {
  // ignore: non_constant_identifier_names
  int customer_id;
  // ignore: non_constant_identifier_names
  int inst_id;
  // ignore: non_constant_identifier_names
  int sale_id;
  // ignore: non_constant_identifier_names
  double inst_real_value;
  // ignore: non_constant_identifier_names
  double payed_value;
  // ignore: non_constant_identifier_names
  String real_date;
  // ignore: non_constant_identifier_names
  String payed_date;
  int payed;

  Installments({
    this.payed,
    // ignore: non_constant_identifier_names
    this.customer_id,
    // ignore: non_constant_identifier_names
    this.inst_id,
    // ignore: non_constant_identifier_names
    this.real_date,
    // ignore: non_constant_identifier_names
    this.payed_date,
    // ignore: non_constant_identifier_names
    this.sale_id,
    // ignore: non_constant_identifier_names
    this.inst_real_value,
    // ignore: non_constant_identifier_names
    this.payed_value,
  });

  Future<List<Installments>> productInstallments(int saleID) async {
    final db = await DBHelper.database;
    var rs = await db.rawQuery(
        "select * from installments where sale_id=" + saleID.toString() + "");

    List<Installments> installments = [];

    int index = 0;
    while (index != rs.length) {
      Installments ins = new Installments();
      ins.inst_id = rs[index]["inst_id"];
      ins.customer_id = rs[index]["customer_id"];
      ins.sale_id = rs[index]["sale_id"];
      ins.inst_real_value = rs[index]["inst_real_value"];
      ins.payed_value = rs[index]["payed_value"];
      ins.payed = rs[index]["payed"];
      ins.real_date = rs[index]["real_date"];
      ins.payed_date = rs[index]["payed_date"];
      installments.add(ins);
      index++;
    }
    return installments;
  }
}
