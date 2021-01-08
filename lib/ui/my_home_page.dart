import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'add_process_page.dart';
import 'appbar_widget.dart';
import 'drawer_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  var _income = 1200.0;
  var _amount = 8000.0;
  var _expense = 600.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        drawer: DrawerPage(),
        appBar: AppBarWidget(),
        backgroundColor: Colors.white,
        floatingActionButton: WillPopScope(
          onWillPop: () {
            Navigator.pop(context, false);
            return Future.value(false);
          },
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProcessPage(),
                ),
              );
            },
            //backgroundColor: Colors.pinkAccent.shade200,
            child: Icon(
              Icons.edit_outlined,
              size: 37,
              color: Colors.indigo,
            ),
            elevation: 10,
            backgroundColor: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    //color: Colors.indigo,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Gelir :",
                              ),
                              Text(
                                _income.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Bakiye :",
                              ),
                              Text(
                                _amount.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Gider :",
                              ),
                              Text(
                                _expense.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.black,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigoAccent,
                  ),
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    child: Text("Tarih Seçimi"),
                    onPressed: () {},
                  ),
                ),
                flex: 1,
              ),
              SizedBox(height: 2,),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: ListView(

                  ),
                ),
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
