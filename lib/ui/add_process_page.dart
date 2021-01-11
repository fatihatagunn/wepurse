import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/ui/my_home_page.dart';
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
    return Material(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBarWidget.withTitle("İşlem Ekle/Düzenle"),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Kategori Seçimi ",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            DropdownButton<String>(
                              iconEnabledColor: Colors.white,
                              dropdownColor: Colors.indigo,
                              items: categories.map((chosenCategory) {
                                return DropdownMenuItem<String>(
                                  child: Text(
                                    chosenCategory,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
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
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Hesap Seçimi",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            DropdownButton<String>(
                              iconEnabledColor: Colors.white,
                              dropdownColor: Colors.indigo,
                              items: accounts.map((chosenAccount) {
                                return DropdownMenuItem<String>(
                                  child: Text(
                                    chosenAccount,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
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
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "İşlem Seçimi",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            RadioListTile<String>(
                              activeColor: Colors.white,
                              value: "Gelir",
                              groupValue: process,
                              onChanged: (value) {
                                setState(() {
                                  process = value;
                                });
                              },
                              title: Text(
                                "Gelir",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            RadioListTile<String>(
                              activeColor: Colors.white,
                              value: "Gider",
                              groupValue: process,
                              onChanged: (value) {
                                setState(() {
                                  process = value;
                                });
                              },
                              title: Text(
                                "Gider",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                ),
                padding: EdgeInsets.only(
                  left: 10,
                  top: 5,
                  right: 20,
                  bottom: 5,
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "İşlem Tutarını Giriniz",
                    prefixIcon: Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                ),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: RaisedButton(
                  child: Text("Tarih Seçiniz"),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                ),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  autofocus: false,
                  focusNode: _focusNode,
                  maxLines: maxLine,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Açıklama Giriniz.",
                    prefixIcon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.done_outline_outlined,
            color: Colors.indigo,
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
      ),
    );
  }
}
