import 'package:ta2set_app/helpers/db_helpers.dart';
import 'package:ta2set_app/models/today.dart';

class Products {
  int id;
  int customer;
  int sublayer;
  // ignore: non_constant_identifier_names
  double buying_price;
  // ignore: non_constant_identifier_names
  double selling_price;
  String name;
  String date;
  int saleID;
//======== DONE =================
  Future<void> addproduct({
    String name,
    int sublayer,
    // ignore: non_constant_identifier_names
    double buying_price,
  }) async {
    final db = await DBHelper.database;
    Today day = new Today();
    String d = await day.getdate();
    String sql =
        "insert into products(sublayer_id,buying_price,Date,name) values('" +
            sublayer.toString() +
            "','" +
            buying_price.toString() +
            "','" +
            d +
            "','" +
            name +
            "')";
    db.rawInsert(sql);
  }

//======== DONE =================
  Future<List<Products>> allproducts() async {
    final db = await DBHelper.database;
    String sql = "select * from products";

    var rs = await db.rawQuery(sql);
    List<Products> products = [];
    int index = 0;
    while (index != rs.length) {
      Products pro = new Products();
      pro.id = rs[index]["product_id"];
      pro.customer = rs[index]["customer_id"];
      pro.name = rs[index]["name"];
      pro.sublayer = rs[index]["sublayer_id"];
      pro.date = rs[index]["Date"];
      pro.buying_price = rs[index]["buying_price"];
      pro.selling_price = rs[index]["selling_price"];
      products.add(pro);
      index++;
    }
    return products;
  }

//======== DONE =================
  Future<List<Products>> customerProducts(int customerID) async {
    final db = await DBHelper.database;
    var rs = await db.rawQuery("select * from products where customer_id=" +
        customerID.toString() +
        "");
    var itemDate = await db.rawQuery(
        "select startdate from sales where customer_id=" +
            customerID.toString() +
            "");
    var saleID = await db.rawQuery(
        "select sale_id from sales where customer_id=" +
            customerID.toString() +
            "");
    List<Products> products = [];

    int index = 0;
    while (index != rs.length) {
      Products pro = new Products();
      pro.id = rs[index]["product_id"];
      pro.customer = rs[index]["customer_id"];
      pro.saleID = saleID[index]["sale_id"];
      pro.name = rs[index]["name"];
      pro.sublayer = rs[index]["sublayer_id"];
      pro.date = itemDate[index]["startdate"];
      pro.buying_price = rs[index]["buying_price"];
      pro.selling_price = rs[index]["selling_price"];
      products.add(pro);
      index++;
    }
    return products;
  }
}
