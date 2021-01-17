import 'package:flutter/material.dart';
import 'package:wepurseapp/services/database_helper_service.dart';
import 'package:wepurseapp/ui/my_home_page.dart';

import 'ui/create_user_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _databaseHelper.kullaniciyiGetir(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data.isEmpty ? CreateUserPage() : MyHomePage();
        } else
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }
}
