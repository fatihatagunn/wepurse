import 'package:flutter/material.dart';
import 'package:wepurseapp/model/gider_model.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';

import 'add_process_page.dart';
import 'appbar_widget.dart';

class AllExpensesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllExpensesPageState();
  }
}

class AllExpensesPageState extends State<AllExpensesPage> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  int length;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBarWidget.withTitle("Tüm Giderler"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(
          Icons.add_circle_outline,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddProcessPage(),
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
          child: FutureBuilder<List<GiderModel>>(
            future: _databaseHelper.giderleriGetir(),
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
                                title: Text(snapshot.data[length - index - 1]
                                        .giderAciklamasi +
                                    '  ' +
                                    snapshot
                                        .data[length - index - 1].giderTarihi),
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
                                            child: Text("a"),
                                          );
                                      },
                                    ),
                                    Text('  '),
                                    FutureBuilder<KategoriModel>(
                                      future: _databaseHelper.getCategory(
                                          categoryID: snapshot
                                              .data[length - index - 1]
                                              .categoryID),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              '(${snapshot.data.kategoriAdi})');
                                        } else
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                      },
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  snapshot.data[length - index - 1].giderTutari
                                          .toString() +
                                      ' TL',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.red,
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
                                    .deleteExpense(snapshot.data[index].giderID)
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
                          ),
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
    );
  }
}
