import 'package:flutter/material.dart';
import 'appbar_widget.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCategoryPageState();
  }
}

class AddCategoryPageState extends State<AddCategoryPage> {
  String process = "";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBarWidget.withTitle("Kategori Ekle/Düzenle"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.teal,
                    child: Align(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Kategori Adı",
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "İşlem Tipini Seçiniz",
                          style: TextStyle(fontSize: 20),
                        ),
                        RadioListTile(
                          value: "Gelir",
                          groupValue: process,
                          onChanged: (value) {
                            setState(() {
                              process = value;
                            });
                          },
                          title: Text("Gelir"),
                        ),
                        RadioListTile(
                          value: "Gelir",
                          groupValue: process,
                          onChanged: (value) {
                            setState(() {
                              process = value;
                            });
                          },
                          title: Text("Gelir"),
                        ),
                      ],
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      "Kategori ikon seçimi yapılacak . "
                          "DropDownMenuItem döndüren fonksiyon",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  flex: 2,
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
            size: 37,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
