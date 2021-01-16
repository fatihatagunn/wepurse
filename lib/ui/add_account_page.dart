import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/ui/my_home_page.dart';
import 'appbar_widget.dart';

class AddAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddAccountPageState();
  }
}

class AddAccountPageState extends State<AddAccountPage> {
  FocusNode _focusNode;

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
        backgroundColor: Colors.indigo,
        appBar: AppBarWidget.withTitle("Hesap Ekle/Düzenle"),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.done_outline_outlined,
            size: 30,
            color: Colors.white,
          ),
          backgroundColor: Colors.indigo,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 8,
                    bottom: 5,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.credit_card,
                        color: Colors.indigo,
                      ),
                      labelText: "Hesap Adı",
                      labelStyle: TextStyle(
                        color: Colors.indigo,
                      ),
                      hintText: "Hesap Adını Giriniz",
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
}
