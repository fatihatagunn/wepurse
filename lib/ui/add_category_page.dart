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
            "Kategori Ekle",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Text("Kategori Adı"),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
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
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.category,
                      ),
                      hintText: "Kategori Adını Giriniz",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("İşlem Seçimi"),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.005),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.2, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
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
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
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
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.2, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff1565c0),
                    ),
                    child: Text(
                      "Kaydet",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
