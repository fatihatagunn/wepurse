import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/model/account_type.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';

import 'appbar_widget.dart';

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
    return Material(
      child: Scaffold(
        appBar: AppBarWidget.withTitle("Hesap Ekle/Düzenle"),
        body: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.circular(10),

            //shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (value) {
                          hesapAdi = value;
                        },
                        maxLength: 20,
                        maxLengthEnforced: true,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          labelText: "Hesap Adını Giriniz",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.done_outline_outlined,
            size: 30,
            color: Colors.indigo,
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            _formKey.currentState.save();
            _databaseHelper
                .hesapEkle(HesapModel(hesapAdi: hesapAdi, accountTypeID: accountType, cutOffDate: '1'))
                .then((value) {});
            showAlertDialog(context);
          },
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
