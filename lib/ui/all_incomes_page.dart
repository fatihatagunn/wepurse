import 'package:flutter/material.dart';
import 'appbar_widget.dart';

class AllIncomesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllIncomesPageState();
  }
}

class AllIncomesPageState extends State<AllIncomesPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBarWidget.withTitle("Tüm Gelirler "),
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
