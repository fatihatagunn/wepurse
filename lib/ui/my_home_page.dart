import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/model/gelir_model.dart';
import 'package:wepurseapp/model/gider_model.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';

import 'add_process_page.dart';
import 'appbar_widget.dart';
import 'drawer_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future gelirleriGetir;

  @override
  void initState() {
    super.initState();
    gelirleriGetir = _databaseHelper.getTotalIncomes();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBarWidget(),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProcessPage(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        //backgroundColor: Colors.pinkAccent.shade200,
        child: Icon(
          Icons.edit_outlined,
          size: 37,
          color: Colors.indigo,
        ),
        elevation: 10,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Gelir",
                        ),
                        FutureBuilder(
                          future: _databaseHelper.getTotalIncomes(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data.toString());
                            } else
                              return Text("0");
                          },
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.black,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Bakiye :",
                        ),
                        FutureBuilder(
                          future: _databaseHelper.getBalances(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data.toString());
                            } else {
                              return Text("0");
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.black,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Gider :",
                        ),
                        FutureBuilder(
                          future: _databaseHelper.getTotalExpenses(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data.toString());
                            } else {
                              return Text("0");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<GelirModel>>(
                future: _databaseHelper.gelirleriGetir(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey.shade400,
                          child: ListTile(
                            title: Text(snapshot.data[index].gelirAciklamasi +
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
                                        child: CircularProgressIndicator(),
                                      );
                                  },
                                ),
                                Text('  '),
                                FutureBuilder<KategoriModel>(
                                  future: _databaseHelper.getCategory(
                                      categoryID:
                                          snapshot.data[index].categoryID),
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
                              snapshot.data[index].gelirTutari.toString() +
                                  ' TL',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }),
            FutureBuilder<List<GiderModel>>(
                future: _databaseHelper.giderleriGetir(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white60,
                          child: ListTile(
                            title: Text(snapshot.data[index].giderAciklamasi +
                                '  ' +
                                snapshot.data[index].giderTarihi),
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
                                        child: CircularProgressIndicator(),
                                      );
                                  },
                                ),
                                Text('  '),
                                FutureBuilder<KategoriModel>(
                                  future: _databaseHelper.getCategory(
                                      categoryID:
                                          snapshot.data[index].categoryID),
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
                              snapshot.data[index].giderTutari.toString() +
                                  ' TL',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                })
          ],
        ),
      ),
    );
  }
}
