import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appbar_widget.dart';

class AddProcessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProcessPageState();
  }
}

class AddProcessPageState extends State<AddProcessPage> {

  var value;
  String process = "" ;


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBarWidget.withTitle("İşlem Ekle/Düzenle"),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.done_outline_outlined,
            size: 37,
            color: Colors.indigo,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.red,
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              "DropDownMenuItem'larını döndürecek widgetin yeri ,  "),
                          color: Colors.indigo,
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.indigo,
                          child: Column(
                            children: <Widget>[
                              RadioListTile(
                                value: "Gelir",
                                groupValue: process,
                                onChanged: (value) {
                                  setState(() {
                                    process = value ;
                                    debugPrint("seçilen deger : $value");
                                  });
                                },
                                title: Text("Gelir"),
                              ),
                              RadioListTile(
                                value: "Gider",
                                groupValue: process,
                                onChanged: (value) {
                                  setState(() {
                                    process = value ;
                                    debugPrint("seçilen deger : $value");
                                  });
                                },
                                title: Text("Gider"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Container(
                  color: Colors.orange,
                  width: double.infinity,
                  height: 50,
                ),
                flex: 2,
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  width: double.infinity,
                  height: 50,
                ),
                flex: 2,
              ),
              Expanded(
                child: Container(
                  color: Colors.red,
                  width: double.infinity,
                  height: 50,
                ),
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
