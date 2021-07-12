import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ta2set_app/helpers/db_helpers.dart';

class Today {
  //======== DONE =================
  Future<void> incdate() async {
    final db = await DBHelper.database;
    var rs = await db.rawQuery("select Date from today");
    int i = 0;
    while (i != rs.length) {
      var dateTime = DateTime.parse(rs[i]["Date"]);

      var addMonth = Jiffy(dateTime).add(months: 1).dateTime;
      var newDate = DateFormat("yyyy-MM-dd").format(addMonth);
      await db.rawUpdate("update today set Date='" + newDate + "'");
      i++;
    }
  }

//======== DONE =================
  Future<String> getdate() async {
    final db = await DBHelper.database;
    String date = "";
    var rs = await db.rawQuery("select Date from today");
    int i = 0;
    while (i != rs.length) {
      date = rs[i]["Date"];
      i++;
    }
    return date;
  }
}
