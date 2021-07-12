import 'package:ta2set_app/helpers/db_helpers.dart';

class User {
  //======== DONE =================
  Future<int> login(String username, String password) async {
    final db = await DBHelper.database;
    var rs = await db.rawQuery("SELECT * from user");
    int i = 0;
    while (i != rs.length) {
      if (username == rs[i]["username"] && password == rs[i]["password"]) {
        if (rs[i]["role"] == 1) {
          await setonline(rs[i]["user_id"], rs[i]["username"]);
          await db.rawUpdate("update online set user_id=" +
              rs[i]["user_id"].toString() +
              ",username='" +
              rs[i]["username"] +
              "'");
          return 1;
        } else if (rs[i]["role"] == 2) {
          setonline(rs[i]["user_id"], rs[i]["username"]);
          return 0;
        }
      }
      i++;
    }

    return -1;
  }

//======== DONE =================
  Future<void> setonline(int id, String name) async {
    final db = await DBHelper.database;
    db.rawUpdate("update online set User_id=" +
        id.toString() +
        ",Username='" +
        name +
        "' where 1");
  }

  Future<void> userList() async {
    final db = await DBHelper.database;
    var rs = await db.rawQuery("SELECT * from user");
    print(rs[0]["role"]);
    var rsss = await db.rawQuery("SELECT * from online");
    print(rsss.length);
  }
}
