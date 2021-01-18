import 'package:flutter/material.dart';
import 'package:wepurseapp/model/gider_model.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';
import 'package:wepurseapp/ui/my_home_page.dart';

import 'add_process_page.dart';

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
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyHomePage()));
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProcessPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.grey.shade600,
                    size: 30,
                  ),
                ))
          ],
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Tüm Giderler",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: FutureBuilder<List<GiderModel>>(
          future: _databaseHelper.giderleriGetir(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              length = snapshot.data.length;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                  snapshot
                                      .data[length - index - 1].giderAciklamasi,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    FutureBuilder<HesapModel>(
                                      future: _databaseHelper.getAccount(
                                          accountID:
                                              snapshot.data[index].accountID),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data.hesapAdi,
                                            style:
                                                TextStyle(color: Colors.black),
                                          );
                                        } else
                                          return Center(
                                            child: Text(""),
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
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      snapshot.data[length - index - 1]
                                              .giderTutari
                                              .toString() +
                                          ' TL',
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      snapshot
                                          .data[length - index - 1].giderTarihi,
                                    )
                                  ],
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
                              child: Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ),
      ),
    );
  }
}
