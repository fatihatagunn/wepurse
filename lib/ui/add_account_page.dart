import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        appBar: AppBarWidget.withTitle("Hesap Ekle/Düzenle"),
        body: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade200,
            borderRadius: BorderRadius.circular(10),

            //shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextField(
                  //textAlign: TextAlign.center,
                  maxLength: 20,
                  maxLengthEnforced: true,
                  onSubmitted: (String s) => debugPrint("On Submit: $s"),
                  focusNode: _focusNode,

                  decoration: InputDecoration(
                    labelText: "Hesap Adı",
                    hintText: "Hesap Adınızı Giriniz",
                    icon: Icon(Icons.edit),
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
          ),
          backgroundColor: Colors.teal,
          onPressed: (){},
        ),
      ),
    );
  }
}
