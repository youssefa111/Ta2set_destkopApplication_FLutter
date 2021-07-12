import 'package:ta2set_app/helpers/db_helpers.dart';

class Customer {
  String name;
  String phone1;
  String phone2;
  int id;
  Customer({
    this.name,
    this.phone1,
    this.phone2,
    this.id,
  });
//======== DONE =================
  Future<int> addcustomer(String name, String phone1, String phone2) async {
    final db = await DBHelper.database;
    if (await checkphone(phone1) == 0 && await checkphone(phone2) == 0) {
      db.rawInsert("insert into customers(name,phone1,phone2) values('" +
          name +
          "','" +
          phone1 +
          "','" +
          phone2 +
          "')");
      return 1;
    }
    return 0;
  }

//======== DONE =================
  Future<int> checkphone(String phone) async {
    final db = await DBHelper.database;
    var rs = await db.rawQuery('SELECT phone1,phone2 FROM customers');
    rs.forEach(
      (element) {
        if ((element['phone1'] == phone && element['phone1'] != "") ||
            (element['phone2'] == phone && element['phone2'] != "")) {
          return 1;
        }
      },
    );
    return 0;
  }

//======== DONE =================
  Future<int> editcustomer(
      int id, String name, String phone1, String phone2) async {
    final db = await DBHelper.database;

    if (await checkphone(phone1) == 0 && await checkphone(phone2) == 0) {
      db.rawUpdate("update customers set name='" +
          name +
          "' , phone1='" +
          phone1 +
          "' , phone2='" +
          phone2 +
          "'   where customer_id=" +
          id.toString() +
          "");
      return 1;
    }
    return 0;
  }

//======== DONE =================
  Future<List<Customer>> viewcustomers() async {
    List<Customer> ac = [];
    final db = await DBHelper.database;

    var rs = await db.rawQuery("select * from customers");
    rs.forEach((element) {
      ac.add(Customer(
          id: element["customer_id"],
          name: element["name"],
          phone1: element["phone1"],
          phone2: element["phone2"]));
    });
    return ac;
  }

//======== DONE =================
  Future<Customer> getcustomerbyid(int id) async {
    final db = await DBHelper.database;

    var rs = await db.rawQuery(
        "select * from customers where customer_id=" + id.toString() + "");
    rs.forEach((element) {
      this.id = element["customer_id"];
      this.name = element["name"];
      this.phone1 = element["phone1"];
      this.phone2 = element["phone2"];
    });
    return this;
  }

//======== DONE =================
  Future<Customer> getcustomerbyphone(String phone) async {
    if (phone != "") {
      final db = await DBHelper.database;

      var rs = await db.rawQuery("select * from customers where phone1='" +
          phone +
          "' or phone2='" +
          phone +
          "'");
      rs.forEach((element) {
        this.id = element["customer_id"];
        this.name = element["name"];
        this.phone1 = element["phone1"];
        this.phone2 = element["phone2"];
      });
      return this;
    }
    return this;
  }
}
