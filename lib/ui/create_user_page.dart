import 'package:flutter/material.dart';
import 'appbar_widget.dart';
import 'my_home_page.dart';

class CreateUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateUserPageState();
  }
}

class CreateUserPageState extends State<CreateUserPage> {
  String _userName, _userMail;
  bool autoControl = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.indigo,
          hintColor: Colors.black54,
          accentColor: Colors.indigo,
          cursorColor: Colors.indigo,
          errorColor: Colors.red,
        ),
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBarWidget.withTitle("Kullanıcı Oluştur"),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              autovalidate: autoControl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Kullanıcı Adı ",
                      hintText: "Kullanıcı adınızı giriniz.",
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.indigo,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: _inputNameControl,
                    onSaved: (inputData) => _userName = inputData,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "E-posta",
                      hintText: "Geçerli bir e-posta giriniz.",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.indigo,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: _inputMailControl,
                    onSaved: (inputData) => _userMail = inputData,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    child: Text(
                      "Kaydet",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.indigo,
                    onPressed: () {
                      _inputDataControl();
                      if (_userName != null && _userMail != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _inputDataControl() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      // debugPrint(" $_userMail  , $_userName ...");
    } else {
      setState(() {
        autoControl = true;
      });
    }
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