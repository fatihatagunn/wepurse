import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/model/gelir_model.dart';
import 'package:wepurseapp/model/gider_model.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';

import 'add_process_page.dart';
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
  int index = 0;

  @override
  void initState() {
    super.initState();
    gelirleriGetir = _databaseHelper.getTotalIncomes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "WePurse",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
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
        child: Icon(Icons.add, size: 30, color: Color(0xff1565c0)),
        elevation: 10,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          children: <Widget>[
            Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xff1565c0),
                            borderRadius: BorderRadius.circular(10)),
                        child: FutureBuilder<double>(
                          future: _databaseHelper.getTotalIncomes(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                (snapshot.data.floor()).toString() + " TL",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              );
                            } else
                              return Text(
                                "0 TL",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Gelir",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xff1565c0),
                            borderRadius: BorderRadius.circular(10)),
                        child: FutureBuilder<double>(
                          future: _databaseHelper.getBalances(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                (snapshot.data.floor()).toString() + " TL",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              );
                            } else
                              return Text("0 TL",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Bakiye",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xff1565c0),
                            borderRadius: BorderRadius.circular(10)),
                        child: FutureBuilder<double>(
                          future: _databaseHelper.getTotalExpenses(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                (snapshot.data.floor()).toString() + " TL",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              );
                            } else
                              return Text("0 TL",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Gider",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.4,
                      height: size.height * 0.05,
                      child: Text(
                        "Gelirler",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xff43a047),
                          border: Border.all(width: 0.2, color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.4,
                      height: size.height * 0.05,
                      child: Text(
                        "Giderler",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xffd32f2f),
                          border: Border.all(width: 0.2, color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            if (index == 0)
              FutureBuilder<List<GelirModel>>(
                  future: _databaseHelper.gelirleriGetir(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff43a047),
                            ),
                            child: ListTile(
                              title: Text(
                                snapshot.data[index].gelirAciklamasi,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                                          style: TextStyle(color: Colors.white),
                                        );
                                      } else
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                    },
                                  ),
                                  FutureBuilder<KategoriModel>(
                                    future: _databaseHelper.getCategory(
                                        categoryID:
                                            snapshot.data[index].categoryID),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          '  (${snapshot.data.kategoriAdi})',
                                          style: TextStyle(color: Colors.white),
                                        );
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
                                    (snapshot.data[index].gelirTutari.floor())
                                            .toString() +
                                        ' TL',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[index].gelirTarihi,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
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
            else
              FutureBuilder<List<GiderModel>>(
                  future: _databaseHelper.giderleriGetir(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffd32f2f),
                            ),
                            child: ListTile(
                              title: Text(
                                snapshot.data[index].giderAciklamasi,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                                          style: TextStyle(color: Colors.white),
                                        );
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
                                          '(${snapshot.data.kategoriAdi})',
                                          style: TextStyle(color: Colors.white),
                                        );
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
                                    (snapshot.data[index].giderTutari.floor())
                                            .toString() +
                                        ' TL',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[index].giderTarihi,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
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
