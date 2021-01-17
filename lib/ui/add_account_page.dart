import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/ekran_dokunma_klavye_kapanma.dart';
import 'package:wepurseapp/model/account_type.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';
import 'package:wepurseapp/ui/accounts_page.dart';

class AddAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddAccountPageState();
  }
}

class AddAccountPageState extends State<AddAccountPage> {
  FocusNode _focusNode;
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  String hesapAdi;

  int accountType;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
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
            "Hesap Ekle/Düzenle",
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
            _formKey.currentState.save();
            _databaseHelper
                .hesapEkle(HesapModel(
                    hesapAdi: hesapAdi,
                    accountTypeID: accountType,
                    cutOffDate: '1'))
                .then((value) {});
            showAlertDialog(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AccountsPage()));
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
                        hesapAdi = value;
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
                        labelText: "Hesap Adı",
                        hintText: "Hesap Adını Giriniz",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Hesap Türü Seçimi : "),
                        FutureBuilder<List<AccountType>>(
                          future: _databaseHelper.getAccountTypes(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print('getted account types!!!');
                              return DropdownButton(
                                items: snapshot.data.map((types) {
                                  return DropdownMenuItem(
                                    child: Text(types.accountTypeName),
                                    value: types.accountTypeID,
                                  );
                                }).toList(),
                                onChanged: (chosenData) {
                                  setState(() {
                                    accountType = chosenData;
                                  });
                                },
                                value: accountType,
                              );
                            } else
                              return CircularProgressIndicator();
                          },
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

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hesap Başarıyla Eklendi"),
        );
      },
    );
  }
}

/*
FutureBuilder<List<AccountType>>(
                        future: _databaseHelper.getAccountTypes(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print('getted account types!!!');
                            return DropdownButton(
                              items: snapshot.data.map((types) {
                                return DropdownMenuItem(
                                  child: Text(types.accountTypeName),
                                  value: types.accountTypeID,
                                );
                              }).toList(),
                              onChanged: (chosenData) {
                                setState(() {
                                  accountType = chosenData;
                                });
                              },
                              value: accountType,
                            );
                          } else
                            return CircularProgressIndicator();
                        },
                      ),
 */
