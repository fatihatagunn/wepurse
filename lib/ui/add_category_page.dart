import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/ekran_dokunma_klavye_kapanma.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCategoryPageState();
  }
}

class AddCategoryPageState extends State<AddCategoryPage> {
  String chosenProcess = "Gelir";

  List<String> processes = ["Gelir", "Gider", 'Gelir ve Gider'];

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
    Size size = MediaQuery.of(context).size;
    return KlavyeninKapanmasi(
      widget: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Kategori Ekle/Düzenle",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
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
                      kategoriAdi: categoryName,
                      processTypeID: chosenProcess == 'Gelir'
                          ? 1
                          : (chosenProcess == 'Gider' ? 2 : 3)))
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
                          Icons.edit,
                        ),
                        labelText: "Kategori Adı",
                        hintText: "Kategori Adını Giriniz",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("İşlem Seçimi : "),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
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
                        ),
                      ],
                    ),
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
