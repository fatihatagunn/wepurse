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
            "Hesap Ekle",
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
                Text("Hesap Adı"),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
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
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.category,
                    ),
                    hintText: "Hesap Adını Giriniz",
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Hesap Türü Seçimi"),
                SizedBox(
                  height: 8,
                ),
                FutureBuilder<List<AccountType>>(
                  future: _databaseHelper.getAccountTypes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: size.height * 0.001),
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
                            hint: Text("Hesap Türünü Seçiniz"),
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
                          ),
                        ),
                      );
                    } else
                      return CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    _formKey.currentState.save();
                    _databaseHelper
                        .hesapEkle(HesapModel(
                            hesapAdi: hesapAdi,
                            accountTypeID: accountType,
                            cutOffDate: '1'))
                        .then((value) {});
                    showAlertDialog(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AccountsPage()));
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
