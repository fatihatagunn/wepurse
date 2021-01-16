import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';

import 'appbar_widget.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCategoryPageState();
  }
}

class AddCategoryPageState extends State<AddCategoryPage> {
  String chosenProcess = "Gelir";

  List<String> processes = ["Gelir", "Gider"];

  String categoryName;
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper _databaseHelper = DatabaseHelper();

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Kategori Başarıyla Eklendi"),
        );
      },
    );
  }

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
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _databaseHelper
                  .kategoriEkle(KategoriModel(
                      kategoriAdi: categoryName, kategoriTipi: chosenProcess))
                  .then((value) {
                showAlertDialog(context);
              });
            }
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
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 8,
                      bottom: 5,
                    ),
                    child: TextFormField(
                      onSaved: (value) {
                        categoryName = value;
                      },
                      validator: (value) {
                        if (value.length < 4) {
                          return "Lütfen en az 4 karakter giriniz ";
                        } else
                          return null;
                      },
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
