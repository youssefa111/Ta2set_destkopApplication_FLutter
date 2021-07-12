import 'package:intl/intl.dart';
import 'package:ta2set_app/helpers/db_helpers.dart';
import 'package:jiffy/jiffy.dart';

//======== DONE =================
class Sell {
  Future<void> sell({
    // ignore: non_constant_identifier_names
    int customer_id,
    // ignore: non_constant_identifier_names
    int product_id,
    double total,
    double downpayment,
    // ignore: non_constant_identifier_names
    int no_of_installments,
    // ignore: non_constant_identifier_names
    double value_of_installment,
    int period,
    String startdate,
  }) async {
    final db = await DBHelper.database;

    print(startdate);
    db.rawInsert(
        "insert into sales(customer_id,product_id,total_price,downpayment,no_of_installment,value_of_installment,period,startdate)" +
            "values(" +
            customer_id.toString() +
            "," +
            product_id.toString() +
            "," +
            total.toString() +
            "," +
            downpayment.toString() +
            "," +
            no_of_installments.toString() +
            "," +
            value_of_installment.toString() +
            "," +
            period.toString() +
            ",'" +
            startdate +
            "')");

    var rs = await db.rawQuery(
        "select sale_id,customer_id,value_of_installment from sales where sale_id=(select MAX(sale_id) from sales)");

    // ignore: non_constant_identifier_names
    int sale_id = -1;
    int cid = -1;
    double value = 0.0;
    int index = 0;
    double sum = 0;
    double lastInstallment = 0;
    while (index != rs.length) {
      sale_id = rs[index]["sale_id"];
      cid = rs[index]["customer_id"];
      value = rs[index]["value_of_installment"];
      index++;
    }
    if (period == 0) {
      for (int i = 0; i < no_of_installments; i++) {
        if (i == no_of_installments - 1) {
          lastInstallment = (total - downpayment) - sum;
          await db.rawInsert(
              "insert into installments(customer_id,sale_id,inst_real_value,real_date) values(" +
                  cid.toString() +
                  "," +
                  sale_id.toString() +
                  "," +
                  lastInstallment.toString() +
                  ",'" +
                  startdate +
                  "')");
        } else {
          await db.rawInsert(
              "insert into installments(customer_id,sale_id,inst_real_value,real_date) values(" +
                  cid.toString() +
                  "," +
                  sale_id.toString() +
                  "," +
                  value.toString() +
                  ",'" +
                  startdate +
                  "')");
        }
        sum = sum + value;
        startdate = this.addday(startdate);
      }
    } else if (period == 1) {
      for (int i = 0; i < no_of_installments; i++) {
        if (i == no_of_installments - 1) {
          lastInstallment = (total - downpayment) - sum;
          await db.rawInsert(
              "insert into installments(customer_id,sale_id,inst_real_value,real_date) values(" +
                  cid.toString() +
                  "," +
                  sale_id.toString() +
                  "," +
                  lastInstallment.toString() +
                  ",'" +
                  startdate +
                  "')");
        } else {
          await db.rawInsert(
              "insert into installments(customer_id,sale_id,inst_real_value,real_date) values(" +
                  cid.toString() +
                  "," +
                  sale_id.toString() +
                  "," +
                  value.toString() +
                  ",'" +
                  startdate +
                  "')");
        }
        sum = sum + value;
        startdate = this.addweak(startdate);
      }
    } else if (period == 2) {
      for (int i = 0; i < no_of_installments; i++) {
        if (i == no_of_installments - 1) {
          lastInstallment = (total - downpayment) - sum;
          await db.rawInsert(
              "insert into installments(customer_id,sale_id,inst_real_value,real_date) values(" +
                  cid.toString() +
                  "," +
                  sale_id.toString() +
                  "," +
                  lastInstallment.toString() +
                  ",'" +
                  startdate +
                  "')");
        } else {
          await db.rawInsert(
              "insert into installments(customer_id,sale_id,inst_real_value,real_date) values(" +
                  cid.toString() +
                  "," +
                  sale_id.toString() +
                  "," +
                  value.toString() +
                  ",'" +
                  startdate +
                  "')");
        }
        sum = sum + value;
        startdate = this.addmonth(startdate);
      }
    } else if (period == 3) {
      for (int i = 0; i < no_of_installments; i++) {
        if (i == no_of_installments - 1) {
          lastInstallment = (total - downpayment) - sum;
          await db.rawInsert(
              "insert into installments(customer_id,sale_id,inst_real_value,real_date) values(" +
                  cid.toString() +
                  "," +
                  sale_id.toString() +
                  "," +
                  lastInstallment.toString() +
                  ",'" +
                  startdate +
                  "')");
        } else {
          await db.rawInsert(
              "insert into installments(customer_id,sale_id,inst_real_value,real_date) values(" +
                  cid.toString() +
                  "," +
                  sale_id.toString() +
                  "," +
                  value.toString() +
                  ",'" +
                  startdate +
                  "')");
        }
        sum = sum + value;
        startdate = this.addyear(startdate);
      }
    }
    db.rawUpdate("update products set customer_id = " +
        customer_id.toString() +
        ", selling_price = " +
        total.toString() +
        " where product_id=" +
        product_id.toString() +
        "");
  }

//======== DONE =================
  String addday(String oldDate) {
    var dateTime = DateTime.parse(oldDate);

    var addDay = Jiffy(dateTime).add(days: 1).dateTime;
    var newDate = DateFormat("yyyy-MM-dd").format(addDay);

    return newDate;
  }

//======== DONE =================
  String addmonth(String oldDate) {
    var dateTime = DateTime.parse(oldDate);

    var addMonth = Jiffy(dateTime).add(months: 1).dateTime;
    var newDate = DateFormat("yyyy-MM-dd").format(addMonth);

    return newDate;
  }

//======== DONE =================
  String addyear(String oldDate) {
    var dateTime = DateTime.parse(oldDate);

    var addYear = Jiffy(dateTime).add(years: 1).dateTime;
    var newDate = DateFormat("yyyy-MM-dd").format(addYear);

    return newDate;
  }

//======== DONE =================
  String addweak(String oldDate) {
    var dateTime = DateTime.parse(oldDate);

    var addWeek = Jiffy(dateTime).add(weeks: 1).dateTime;
    var newDate = DateFormat("yyyy-MM-dd").format(addWeek);

    return newDate;
  }
}
