import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/ekran_dokunma_klavye_kapanma.dart';
import 'package:wepurseapp/main.dart';
import 'package:wepurseapp/model/user_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';
import 'package:wepurseapp/ui/my_home_page.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  final _formKey = GlobalKey<FormState>();
  String _userEmail, _userName;
  Future kullaniciyiGetir;

  @override
  void initState() {
    super.initState();
    kullaniciyiGetir = _databaseHelper.kullaniciyiGetir();
    //Backendless.initApp(APPLICATION_ID, ANDROID_API_KEY, IOS_API_KEY);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return KlavyeninKapanmasi(
      widget: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Profili Düzenle",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
          child: FutureBuilder<List<UserModel>>(
            future: kullaniciyiGetir,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("Kullanıcı Adı"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: size.height * 0.08,
                        width: size.width,
                        child: TextFormField(
                          onSaved: (value) {
                            _userName = value;
                          },
                          validator: _inputNameControl,
                          initialValue: snapshot.data[0].userName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Email"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: size.height * 0.08,
                        width: size.width,
                        child: TextFormField(
                          onSaved: (value) {
                            _userEmail = value;
                          },
                          validator: _inputMailControl,
                          initialValue: snapshot.data[0].userEmail,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _databaseHelper
                                .editProfile(
                                    _userEmail != null
                                        ? _userEmail
                                        : snapshot.data[0].userEmail,
                                    _userName != null
                                        ? _userName
                                        : snapshot.data[0].userName)
                                .then((value) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                            });
                          }
                        },
                        child: Container(
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: size.width,
                          alignment: Alignment.center,
                          child: Text(
                            "Güncelle",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showAlertDialog(context);
                        },
                        child: Container(
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: size.width,
                          alignment: Alignment.center,
                          child: Text(
                            "Hesabımı Sil",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Kaydet ve Vazgeç Butonları Oluşturuldu
    Widget kaydetButonu = FlatButton(
        child: Text("Evet"),
        onPressed: () {
          _databaseHelper.deleteUser().then((value) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyApp()));
          });
        });

    Widget vazgecButonu = FlatButton(
        child: Text("Vazgeç"),
        onPressed: () {
          Navigator.of(context).pop(false);
        });

    // show dialog oluşturuldu ve alert dialog döndürüldü
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hesabınızı Silmek İstediğinize Emin misiniz?"),
          actions: [
            vazgecButonu,
            kaydetButonu,
          ],
        );
      },
    );
  }

  String _inputNameControl(String name) {
    if (name.length < 4) {
      return "Kullanıcı adı 4 karakterden uzun olmalı.";
    } else
      return null;
  }

  String _inputMailControl(String mail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(mail))
      return "Gecerli bir e-posta giriniz ";
    else
      return null;
  }
}
