import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBHelper {
  static Database _instance;
  static Future<Database> get database async {
    return _instance ??= await DBHelper._init();
  }

  DBHelper._();

  static Future<Database> _init() async {
    final path = Directory.current.path;
    print(path);
    final dbPath = join(path, 'database.db');
    return await databaseFactoryFfi.openDatabase(dbPath,
        options: OpenDatabaseOptions(
          onCreate: _onCreate,
          version: 1,
        ));
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        Account_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        day TEXT,
        total_income REAL,
        total_payed REAL,
        dayend REAL  NOT NULL
        
)
      ''');
    /*=========================== products Table ========================================================================= */
    await db.execute('''
     CREATE TABLE products (
       product_id INTEGER PRIMARY KEY AUTOINCREMENT,
       Date TEXT,
       name TEXT,
       sublayer_id INTEGER,
       buying_price REAL,
       customer_id INTEGER,
       selling_price REAL,
       FOREIGN KEY (sublayer_id) REFERENCES sublayers (sublayr_id) ON DELETE CASCADE,
       FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE
) 
      ''');
    /*=========================== customers Table ========================================================================= */
    await db.execute('''
      CREATE TABLE customers (
       customer_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       name TEXT ,
       phone1 TEXT ,
       phone2 TEXT ,
       Total_acc REAL NOT NULL DEFAULT 0
)
      ''');
    /*=========================== income Table ========================================================================= */
    await db.execute('''
     CREATE TABLE income (
       income_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       income_type INTEGER ,
       date TEXT,
       value REAL,
       customer_id INTEGER,
       inst_id INTEGER,
       sale_id INTEGER,
       FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE,   
       FOREIGN KEY (inst_id) REFERENCES installments (inst_id) ON DELETE CASCADE,  
       FOREIGN KEY (sale_id) REFERENCES sales (sale_id) ON DELETE CASCADE
)
      ''');

    /*=========================== installments Table ========================================================================= */
    await db.execute('''
     CREATE TABLE installments (
       inst_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       customer_id INTEGER,
       sale_id INTEGER,
       inst_real_value REAL,
       payed_value REAL NOT NULL DEFAULT 0,
       payed INTEGER NOT NULL DEFAULT 0,
       real_date TEXT,
       payed_date TEXT,
       FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE,
       FOREIGN KEY (sale_id) REFERENCES sales (sale_id) ON DELETE CASCADE
)
      ''');
    /*=========================== online Table ========================================================================= */
    await db.execute('''
     CREATE TABLE online (
       online_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       user_id INTEGER,
       username TEXT,
       FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE
)
      ''');
    /*=========================== payments Table ========================================================================= */
    await db.execute('''
     CREATE TABLE payments (
       payment_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       sublayer_id INTEGER,
       Date TEXT,
       value REAL,
       FOREIGN KEY (sublayer_id) REFERENCES sublayers (sublayr_id) ON DELETE CASCADE
)
      ''');
    /*=========================== sales Table ========================================================================= */
    await db.execute('''
     CREATE TABLE sales (
       sale_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       customer_id INTEGER,
       product_id INTEGER,
       total_price REAL,
       downpayment REAL,
       no_of_installment INTEGER,
       value_of_installment REAL,
       period INTEGER NOT NULL,
       startdate TEXT NOT NULL DEFAULT '2020-01-01',
       FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
       FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE
)
      ''');
    /*=========================== suppliers Table ========================================================================= */
    await db.execute('''
     CREATE TABLE sublayers (
       sublayr_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       name TEXT,
       phone1 TEXT,
       phone2 TEXT,
       address TEXT,
       total_acc REAL NOT NULL DEFAULT 0
)
      ''');
    /*=========================== today Table ========================================================================= */
    await db.execute('''
    CREATE TABLE today (
       today_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       Date TEXT NOT NULL
)
      ''');
    /*=========================== user Table ========================================================================= */
    await db.execute('''
   CREATE TABLE user (
       user_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       username TEXT,
       password TEXT,
       role INTEGER
)
      ''');
    /*================================================================================================================= */
    await db.insert("user", {
      "username": "admin123",
      "password": "admin123",
      "role": 1,
    });
    await db.insert("online", {
      "username": "admin123",
      "user_id": 1,
    });
    await db.insert("today", {
      "Date": "4/2/2021",
    });
    print('database created ! version: $version');
  }
}
