import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appbar_widget.dart';
import 'my_home_page.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCategoryPageState();
  }
}

class AddCategoryPageState extends State<AddCategoryPage> {
  String chosenProcess = "Gelir";

  List<String> processes = ["Gelir", "Gider"];

//  Icon chosenIcon = Icon(Icons.account_balance_wallet_outlined);

 // List<Icon> icons = [
   // Icon(Icons.icecream),
    //Icon(Icons.account_balance_wallet_outlined)
  //];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        resizeToAvoidBottomPadding: false,
        appBar: AppBarWidget.withTitle("Kategori Ekle/Düzenle"),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(
            Icons.done_outline_outlined,
            color: Colors.white,
            size: 37,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 8,
                    bottom: 5,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.category_outlined,
                      ),
                      labelText: "Kategori Adı",
                      hintText: "Kategori Adını Giriniz",
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("İşlem Seçimi"),
                          DropdownButton<String>(
                            items: processes.map((chosenProcess) {
                              return DropdownMenuItem<String>(
                                child: Text(
                                  chosenProcess,
                                ),
                                value: chosenProcess,
                              );
                            }).toList(),
                            onChanged: (chosenData) {
                              setState(() {
                                chosenProcess = chosenData;
                              });
                            },
                            value: chosenProcess,
                          ),
                        ],
                      ),
                    ),
                   /* DropdownButton<Icon>(
                      items: icons.map((chosenIcon) {
                        return DropdownMenuItem<Icon>(
                          child: chosenIcon,
                          value: chosenIcon,
                        );
                      }).toList(),
                      onChanged: (inputData) {
                        setState(() {
                          chosenIcon = inputData;
                        });
                      },
                      value: chosenIcon,
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
