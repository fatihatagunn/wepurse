import 'package:flutter/material.dart';
import 'appbar_widget.dart';

class AccountsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountsPageState();
  }
}

class AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBarWidget.withTitle("Hesaplar "),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(Icons.add_circle_outline , ),
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
