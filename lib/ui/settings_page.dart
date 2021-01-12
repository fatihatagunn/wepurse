import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appbar_widget.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBarWidget.withTitle("Ayarlar"),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "KULLANICI ADI",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "E-posta",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  flex: 3,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Tema Seçimi"),
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          child: Text("Profili Düzenle"),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),

                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment(0, 1),
                      child: RaisedButton(
                        onPressed: (){},
                        child: Text("tüm verileri sil"),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
