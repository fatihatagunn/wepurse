import 'package:flutter/material.dart';
import 'ui/add_process_page.dart';
import 'ui/create_account_page.dart';
import 'ui/my_home_page.dart';
import 'ui/drawer_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  String _userName = "irem sena celik";
  String _userMail = "ssrem@rem.ii";
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateAccountPage(),
    );
  }
}
