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

import 'appbar_widget.dart';

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

  String chosenProcess = "Gelir";

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
                        tutar = double.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.monetization_on_outlined,
                        ),
                        labelText: "İşlem Tutarı",
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
                    child: TextFormField(
                      maxLines: maxLine,
                      maxLength: 50,
                      onSaved: (value) {
                        detay = value;
                      },
                      maxLengthEnforced: true,
                      autofocus: false,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.info_outline_rounded,
                        ),
                        labelText: "Detay ",
                        hintText: "İşlem Detaylarını Giriniz",
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Kategori Seçimi ",
                          ),
                          FutureBuilder<List<KategoriModel>>(
                            future: _databaseHelper.kategorileriGetir(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButton(
                                  hint: Text(snapshot.data[0].kategoriAdi),
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
                                );
                              } else
                                return CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Hesap Seçimi",
                          ),
                          FutureBuilder<List<HesapModel>>(
                            future: _databaseHelper.hesaplariGetir(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButton(
                                  hint: Text(snapshot.data[0].hesapAdi),
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
                                );
                              } else
                                return CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("İşlem Seçimi"),
                      DropdownButton<String>(
                        hint: Text(chosenProcess),
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
                  GestureDetector(
                    onTap: () {
                      dogumTarihleriniAtama();
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: size.height * 0.08,
                      width: size.width * 0.8,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03,
                        vertical: size.height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xffbdbdbd), width: 1),
                      ),
                      child: tarih == null
                          ? Text(
                              "Seçiniz",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.black87),
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
                ],
              ),
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
            _formKey.currentState.save();
            if (chosenProcess == 'Gelir') {
              _databaseHelper
                  .gelirEkle(GelirModel(
                      gelirAciklamasi: detay,
                      gelirTutari: tutar,
                      gelirTarihi: DateFormat.yMMMd('tr').format(tarih),
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
                      giderTarihi: DateFormat.yMMMd('tr').format(tarih),
                      categoryID: category,
                      processTypeID: 2,
                      accountID: account))
                  .then((value) {
                Navigator.pop(context);
              });
            }
          },
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
