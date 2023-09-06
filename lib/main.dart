import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'models/handlers/hive_handler.dart';
import 'models/handlers/shared_prefference_handler.dart';
import 'models/handlers/sql_handler.dart';
import 'screens/my_home_page_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHandler().init();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final sqlHandler = SqlHandler();

  await sqlHandler.initDatabase();
  await sqlHandler.createTable('orders', '''
      id INTEGER PRIMARY KEY,
      user_id INTEGER,
      product TEXT,
      quantity INTEGER
    ''');
  await sqlHandler.insert('users', {'name': 'John', 'email': 'john@example.com'});
  await sqlHandler.insert('users', {'name': 'Alice', 'email': 'alice@example.com'});
  await sqlHandler.insert('orders' , {'user_id': 1, 'product': 'Apple', 'quantity': 5});
  await sqlHandler.insert('orders' , {'user_id': 1, 'product': 'Orange', 'quantity': 10});
  await sqlHandler.insert('orders' , {'user_id': 2, 'product': 'Banana', 'quantity': 15});
final response =await sqlHandler.customQuery(
    '''
      SELECT users.name, orders.product, orders.quantity
      FROM users
      INNER JOIN orders ON users.id = orders.user_id
    '''
);
SharedPreferencesHandler().setString('response', response.toString());
//print(SharedPreferencesHandler().getString('response'));
  final hive = HiveHandler();
  await hive.initHive(['box1', 'box2']); // Initialize Hive with a list of box names
hive.put("box1", "response", response.toString());
print(hive.get("box1", "response"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}
