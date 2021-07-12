import 'package:ta2set_app/helpers/db_helpers.dart';
import 'package:ta2set_app/models/today.dart';

class Admin {
  // ignore: non_constant_identifier_names
  Future<int> collect(int inst_id, double value) async {
    final db = await DBHelper.database;
    Today day = new Today();
    var rs = await db.rawQuery(
        "select inst_real_value,sale_id from installments where inst_id=" +
            inst_id.toString() +
            "");
    // ignore: non_constant_identifier_names
    double real_value = 0;
    // ignore: non_constant_identifier_names
    int sale_id = 0;
    int i = 0;
    while (i < rs.length) {
      real_value = rs[i]["inst_real_value"];
      sale_id = rs[i]["sale_id"];
      i++;
    }
    if (await this.check_total_inst(sale_id, value) == 0) {
      if (real_value == value) {
        db.rawUpdate("update installments set payed=1 , payed_value=" +
            value.toString() +
            ", payed_date='" +
            await day.getdate() +
            "' where inst_id=" +
            inst_id.toString() +
            "");
      } else if (real_value < value) {
        var rs2 = await db.rawQuery(
            "select * from installments where sale_id=" +
                sale_id.toString() +
                " and payed = 0 order by real_date DESC");
        int no = (value ~/ real_value).toInt();
        var ids = new List.filled(10, 0);
        ids[0] = inst_id;
        int z = 1;
        int index = 0;
        while (index < rs.length) {
          ids[z] = rs2[index]["inst_id"];
          z++;
          index++;
        }
        int i = 0;

        for (i = 0; i < no; i++) {
          this.collect(ids[i], real_value);
        }
        if (value - (real_value * no) != 0) {
          this.collect(ids[i], value - (real_value * no));
        }
      } else if (real_value > value) {
        db.rawUpdate("update installments set payed=2 , payed_value=" +
            value.toString() +
            ", payed_date='" +
            await day.getdate() +
            "' where inst_id=" +
            inst_id.toString() +
            "");
      }
      return 1;
    }
    return 0;
  }

  // ignore: non_constant_identifier_names
  Future<void> pay(int sublayer_id, double value) async {
    final db = await DBHelper.database;
    Today day = new Today();
    db.rawInsert("insert into payements(sublayer_id,value,Date) values(" +
        sublayer_id.toString() +
        "," +
        value.toString() +
        ",'" +
        await day.getdate() +
        "')");
  }

  // ignore: non_constant_identifier_names
  Future<int> check_total_inst(int sale_id, double value) async {
    final db = await DBHelper.database;

    var rs = await db.rawQuery(
        "select sum(inst_real_value) as total from  installments where payed=0 and sale_id=" +
            sale_id.toString() +
            "");
    int i = 0;
    double x = 0;
    x = rs[i]["total"];
    while (i < rs.length) {
      print(x);
      if (i == rs.length - 1) {
        if (x == value) {
          return 0;
        }
      }
      if (x > value) {
        return 0;
      }
      i++;
    }
    return 1;
  }
}
