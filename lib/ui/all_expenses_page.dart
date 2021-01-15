import 'package:flutter/material.dart';
import 'add_process_page.dart';
import 'appbar_widget.dart';
import 'my_home_page.dart';

class AllExpensesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllExpensesPageState();
  }
}

class AllExpensesPageState extends State<AllExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBarWidget.withTitle("Tüm Giderler "),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(
            Icons.add_circle_outline,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddProcessPage(),
              ),
            );
          },
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: ListView(),
          ),
        ),
      ),
    );
  }
}
