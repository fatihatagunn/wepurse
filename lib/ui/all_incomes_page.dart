import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/model/gelir_model.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';
import 'package:wepurseapp/ui/add_process_page.dart';

import 'appbar_widget.dart';

class AllIncomesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllIncomesPageState();
  }
}

class AllIncomesPageState extends State<AllIncomesPage> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  int length;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBarWidget.withTitle("Tüm Gelirler"),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddProcessPage(),
              ),
            );
          },
          child: Icon(
            Icons.add_circle_outline,
          ),
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
            child: FutureBuilder<List<GelirModel>>(
              future: _databaseHelper.gelirleriGetir(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  length = snapshot.data.length;
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                color: Colors.white60,
                                child: ListTile(
                                  title: Text(
                                      snapshot.data[index].gelirAciklamasi +
                                          '  ' +
                                          snapshot.data[index].gelirTarihi),
                                  subtitle: Row(
                                    children: [
                                      FutureBuilder<HesapModel>(
                                        future: _databaseHelper.getAccount(
                                            accountID:
                                                snapshot.data[index].accountID),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(snapshot.data.hesapAdi);
                                          } else
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                        },
                                      ),
                                      Text('  '),
                                      FutureBuilder<KategoriModel>(
                                        future: _databaseHelper.getCategory(
                                            categoryID: snapshot
                                                .data[index].categoryID),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                                '(${snapshot.data.kategoriAdi})');
                                          } else
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                        },
                                      ),
                                    ],
                                  ),
                                  trailing: Text(
                                    snapshot.data[index].gelirTutari
                                            .toString() +
                                        ' TL',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.14,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  _databaseHelper
                                      .deleteIncome(
                                          snapshot.data[index].gelirID)
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.white,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
          ),
        ),
      ),
    );
  }
}
