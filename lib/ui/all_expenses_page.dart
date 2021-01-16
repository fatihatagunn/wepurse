import 'package:flutter/material.dart';
import 'package:wepurseapp/model/gider_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBarWidget.withTitle("Tüm Giderler "),
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
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(snapshot.data[index].gelirTutari
                                    .toString()),
                                Text(snapshot.data[index].islemTipi),
                                Text(snapshot.data[index].gelirTarihi),
                                Text(snapshot.data[index].gelirAciklamasi),
                                Text(snapshot.data[index].hesapTipi.toString()),
                                Text(snapshot.data[index].kategoriTipi
                                    .toString()),
                              ],
                            ),
                          ));
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
