import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appbar_widget.dart';
import 'my_home_page.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCategoryPageState();
  }
}

class AddCategoryPageState extends State<AddCategoryPage> {
  String process = "";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBarWidget.withTitle("Kategori Ekle/Düzenle"),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(

                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "İşlem Seçimi ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      RadioListTile<String>(
                        activeColor: Colors.white,
                        value: "Gelir",
                        groupValue: process,
                        onChanged: (value) {
                          setState(() {
                            process = value;
                          });
                        },
                        title: Text(
                          "Gelir",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RadioListTile<String>(
                        activeColor: Colors.white,
                        value: "Gider",
                        groupValue: process,
                        onChanged: (value) {
                          setState(() {
                            process = value;
                          });
                        },
                        title: Text(
                          "Gider",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    maxLines: 1,
                    maxLength: 20,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelText: "Kategori Adını Giriniz",
                      prefixIcon: Icon(
                        Icons.category_outlined,
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox( height: 10,),


                Text("Kategori icon seçimi yapılacak"),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.done_outline_outlined,
            color: Colors.indigo,
            size: 37,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
