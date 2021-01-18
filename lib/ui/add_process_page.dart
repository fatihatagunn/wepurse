import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:wepurseapp/ekran_dokunma_klavye_kapanma.dart';
import 'package:wepurseapp/model/gelir_model.dart';
import 'package:wepurseapp/model/gider_model.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';

class AddProcessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProcessPageState();
  }
}

class AddProcessPageState extends State<AddProcessPage> {
  double inputAmount = 0.0;

  DatabaseHelper _databaseHelper = DatabaseHelper();
  int category;
  int account;

  FocusNode _focusNode;
  var _date;
  var tarih;

  int maxLine = 1;

  String value;
  String process = "";

  String chosenCategory = "Market";

  List<String> categories = ["Ulaşım", "Market", "Giyim", "Su Faturası"];

  String chosenAccount = "Nakit";

  List<String> accounts = ["Nakit", "Maaş Hesabı", "Kredi Kartı"];

  String chosenProcess;

  List<String> processes = ["Gelir", "Gider"];

  final _formKey = GlobalKey<FormState>();

  double tutar;
  String detay;

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
    Size size = MediaQuery.of(context).size;
    return KlavyeninKapanmasi(
      widget: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Gelir/Gider Ekle",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.01),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("İşlem Tutarı"),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      tutar = double.parse(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Bu alanı doldurunuz";
                      } else
                        return null;
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.monetization_on_outlined,
                      ),
                      hintText: "İşlem Tutarını Giriniz",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Detay"),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    maxLines: maxLine,
                    maxLength: 30,
                    onSaved: (value) {
                      detay = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Bu alanı doldurunuz";
                      } else
                        return null;
                    },
                    maxLengthEnforced: true,
                    autofocus: false,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.info_outline_rounded,
                      ),
                      hintText: "İşlem Detaylarını Giriniz",
                    ),
                  ),
                  Text(
                    "Kategori Seçimi ",
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FutureBuilder<List<KategoriModel>>(
                    future: _databaseHelper.kategorileriGetir(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.2, style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("Lütfen kategori seçiniz"),
                              items: snapshot.data.map((kategori) {
                                return DropdownMenuItem(
                                  child: Text(
                                    kategori.kategoriAdi,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: kategori.kategoriID,
                                );
                              }).toList(),
                              onChanged: (chosenData) {
                                setState(() {
                                  category = chosenData;
                                });
                              },
                              value: category,
                            ),
                          ),
                        );
                      } else
                        return CircularProgressIndicator();
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Hesap Seçimi",
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FutureBuilder<List<HesapModel>>(
                    future: _databaseHelper.hesaplariGetir(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.2, style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("Lütfen hesap seçiniz"),
                              items: snapshot.data.map((hesaplar) {
                                return DropdownMenuItem(
                                  child: Text(hesaplar.hesapAdi),
                                  value: hesaplar.hesapID,
                                );
                              }).toList(),
                              onChanged: (chosenData) {
                                setState(() {
                                  account = chosenData;
                                });
                              },
                              value: account,
                            ),
                          ),
                        );
                      } else
                        return CircularProgressIndicator();
                    },
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
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.2, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("Lütfen işlem seçiniz"),
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
                  Text("İşlem Tarihi"),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      dogumTarihleriniAtama();
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03,
                        vertical: size.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xffbdbdbd), width: 1),
                      ),
                      child: tarih == null
                          ? Text(
                              "Lütfen tarih seçiniz",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.grey.shade600),
                            )
                          : Text(
                              DateFormat.yMMMd('tr').format(tarih),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.black),
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
                        if (category == null ||
                            account == null ||
                            chosenProcess == null ||
                            tarih == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Lütfen boş alanları doldurunuz")));
                        } else {
                          if (chosenProcess == 'Gelir') {
                            _databaseHelper
                                .gelirEkle(GelirModel(
                                    gelirAciklamasi: detay,
                                    gelirTutari: tutar,
                                    gelirTarihi:
                                        DateFormat.yMMMd('tr').format(tarih),
                                    categoryID: category,
                                    processTypeID: 1,
                                    accountID: account))
                                .then((value) {
                              Navigator.pop(context);
                            });
                          } else if (chosenProcess == 'Gider') {
                            print('fonksiyon');
                            _databaseHelper
                                .giderEkle(GiderModel(
                                    giderAciklamasi: detay,
                                    giderTutari: tutar,
                                    giderTarihi:
                                        DateFormat.yMMMd('tr').format(tarih),
                                    categoryID: category,
                                    processTypeID: 2,
                                    accountID: account))
                                .then((value) {
                              Navigator.pop(context);
                            });
                          }
                        }
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
                        "Ekle",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
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

  void dogumTarihleriniAtama() async {
    DateTime birthDate =
        await tarihSec(context, DateTime.now(), lastDate: DateTime.now());
    setState(() {
      tarih = birthDate;
    });
  }

  tarihSec(BuildContext context, DateTime initialDateTime,
      {DateTime lastDate}) async {
    Completer completer = Completer();
    if (Platform.isAndroid)
      showDatePicker(
              locale: Locale("tr", "TR"),
              context: context,
              initialDate: initialDateTime,
              firstDate: DateTime(1970),
              lastDate: lastDate == null
                  ? DateTime(initialDateTime.year + 10)
                  : lastDate)
          .then((temp) {
        if (temp == null) return null;
        completer.complete(temp);
        setState(() {});
      });
    else
      DatePicker.showDatePicker(context,
          theme: DatePickerTheme(
            containerHeight: 210.0,
          ),
          showTitleActions: true,
          minTime: DateTime(2000, 1, 1),
          maxTime: DateTime.now(), onConfirm: (date) {
        _date = date;
        completer.complete(_date);
        setState(() {});
      }, currentTime: DateTime.now(), locale: LocaleType.tr);
    return completer.future;
  }
}
