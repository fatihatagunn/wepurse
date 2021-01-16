import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_home_page.dart';
import 'appbar_widget.dart';

class AddProcessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProcessPageState();
  }
}

class AddProcessPageState extends State<AddProcessPage> {
  double inputAmount = 0.0;

  FocusNode _focusNode;

  int maxLine = 1;

  String value;
  String process = "";

  String chosenCategory = "Market";

  List<String> categories = ["Ulaşım", "Market", "Giyim", "Su Faturası"];

  String chosenAccount = "Nakit";

  List<String> accounts = ["Nakit", "Maaş Hesabı", "Kredi Kartı"];

  String chosenProcess = "Gelir";

  List<String> processes = ["Gelir", "Gider"];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          maxLine = 3;
        } else {
          maxLine = 1;
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime monthAgo = DateTime(
      2021,
      today.month - 1,
    );
    DateTime monthAfter = DateTime(
      2021,
      today.month + 1,
    );

    return Material(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        resizeToAvoidBottomPadding: false,
        appBar: AppBarWidget.withTitle("İşlem Ekle/Düzenle"),
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
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      focusColor: Colors.indigo,
                      icon: Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.indigo,
                      ),
                      labelText: "İşlem Tutarı",
                      labelStyle: TextStyle(
                        color: Colors.indigo,
                      ),
                      hintText: "İşlem Tutarını Giriniz",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 8,
                    bottom: 5,
                  ),
                  child: TextField(
                    maxLines: maxLine,
                    maxLength: 50,
                    maxLengthEnforced: true,
                    autofocus: false,
                    focusNode: _focusNode,
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.info_outline_rounded,
                        color: Colors.indigo,
                      ),
                      labelText: "Detay ",
                      labelStyle: TextStyle(
                        color: Colors.indigo,
                      ),
                      hintText: "İşlem Detaylarını Giriniz",
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Kategori Seçimi ",
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 16,
                            ),
                          ),
                          DropdownButton<String>(
                            items: categories.map((chosenCategory) {
                              return DropdownMenuItem<String>(
                                child: Text(
                                  chosenCategory,
                                ),
                                value: chosenCategory,
                              );
                            }).toList(),
                            onChanged: (chosenData) {
                              setState(() {
                                chosenCategory = chosenData;
                              });
                            },
                            value: chosenCategory,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Hesap Seçimi",
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 16,
                            ),
                          ),
                          DropdownButton<String>(
                            items: accounts.map((chosenAccount) {
                              return DropdownMenuItem<String>(
                                child: Text(
                                  chosenAccount,
                                ),
                                value: chosenAccount,
                              );
                            }).toList(),
                            onChanged: (chosenData) {
                              setState(() {
                                chosenAccount = chosenData;
                              });
                            },
                            value: chosenAccount,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 120,
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "İşlem Seçimi",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 16,
                        ),
                      ),
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
                RaisedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: today,
                      firstDate: monthAgo,
                      lastDate: monthAfter,
                    ).then((chosenDate) {
                      today = chosenDate;
                    });
                  },
                  child: Text(
                    "Tarih Seçimi",
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(
            Icons.done_outline_outlined,
            size: 32,
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
      ),
    );
  }
}
