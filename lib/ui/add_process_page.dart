import 'package:flutter/material.dart';
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

  var value;
  String process = "";

  String chosenCategory = "Market";

  List<String> categories = ["Ulaşım", "Market", "Giyim"];

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
        appBar: AppBarWidget.withTitle("İşlem Ekle/Düzenle"),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Kategori Seçimi "),
                                DropdownButton<String>(
                                  items: categories.map((chosenCategory) {
                                    return DropdownMenuItem<String>(
                                      child: Text(chosenCategory),
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
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("İşlem Seçimi"),
                                RadioListTile<String>(
                                  value: "Gelir",
                                  groupValue: process,
                                  onChanged: (data) {
                                    setState(() {
                                      process = data;
                                    });
                                  },
                                  title: Text("Gelir"),
                                ),
                                RadioListTile<String>(
                                  value: "Gider",
                                  groupValue: process,
                                  onChanged: (data) {
                                    setState(() {
                                      process = data;
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
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 70, left: 30),
                      child: TextFormField(
                        //onFieldSubmitted: ,

                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "İşlem Tutarını Giriniz",
                          prefixIcon: Icon(Icons.monetization_on_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text("Tarih Seçiniz"),
                      onPressed: () {},
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 70, left: 30),
                      child: TextFormField(
                        autofocus: false,
                        focusNode: _focusNode,
                        maxLines: maxLine,
                        decoration: InputDecoration(
                          labelText: "Açıklama Giriniz.",
                          prefixIcon: Icon(Icons.info_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.done_outline_outlined,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}
