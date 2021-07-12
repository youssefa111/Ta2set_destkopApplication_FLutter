import 'package:ta2set_app/helpers/db_helpers.dart';

class Supplier {
  String name;
  String phone1;
  String phone2;
  int id;
  String address;
  Supplier({this.name, this.phone1, this.phone2, this.id, this.address});
//======== DONE =================
  Future<int> addsublayer(
      String name, String phone1, String phone2, String address) async {
    final db = await DBHelper.database;
    if (await checkphone(phone1) == 0 && await checkphone(phone2) == 0) {
      db.rawInsert(
          "insert into sublayers(name,phone1,phone2,address) values('" +
              name +
              "','" +
              phone1 +
              "','" +
              phone2 +
              "','" +
              address +
              "')");
      return 1;
    }
    return 0;
  }

//======== DONE =================
  Future<int> checkphone(String phone) async {
    final db = await DBHelper.database;
    var rs = await db.rawQuery('SELECT phone1,phone2 FROM sublayers');
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
  Future<int> editsublayer(
      int id, String name, String phone1, String phone2, String address) async {
    final db = await DBHelper.database;

    if (await checkphone(phone1) == 0 && await checkphone(phone2) == 0) {
      db.rawUpdate("update sublayers set name='" +
          name +
          "' , phone1='" +
          phone1 +
          "' , phone2='" +
          phone2 +
          "' , address='" +
          address +
          "'  where sublayr_id=" +
          id.toString() +
          "");
      return 1;
    }
    return 0;
  }

//======== DONE =================
  Future<List<Supplier>> viewsublayers() async {
    List<Supplier> ac = [];
    final db = await DBHelper.database;

    var rs = await db.rawQuery("select * from sublayers");
    rs.forEach((element) {
      ac.add(Supplier(
        id: element["sublayr_id"],
        name: element["name"],
        phone1: element["phone1"],
        phone2: element["phone2"],
        address: element["address"],
      ));
    });
    return ac;
  }

//======== DONE =================
  Future<Supplier> getcustomerbyid(int id) async {
    final db = await DBHelper.database;

    var rs = await db.rawQuery(
        "select * from sublayers where sublayr_id=" + id.toString() + "");
    rs.forEach((element) {
      this.id = element["sublayr_id"];
      this.name = element["name"];
      this.phone1 = element["phone1"];
      this.phone2 = element["phone2"];
      this.address = element["address"];
    });
    return this;
  }

//======== DONE =================
  Future<Supplier> getsuplayerbyphone(String phone) async {
    if (phone != "") {
      final db = await DBHelper.database;

      var rs = await db.rawQuery("select * from sublayers where phone1='" +
          phone +
          "' or phone2='" +
          phone +
          "'");
      rs.forEach((element) {
        this.id = element["sublayr_id"];
        this.name = element["name"];
        this.phone1 = element["phone1"];
        this.phone2 = element["phone2"];
        this.address = element["address"];
      });
      return this;
    }
    return this;
  }
}
