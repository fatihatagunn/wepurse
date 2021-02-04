import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';

import 'add_account_page.dart';

class AccountsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountsPageState();
  }
}

class AccountsPageState extends State<AccountsPage> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAccountPage(),
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
          "Hesaplar",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<HesapModel>>(
        future: _databaseHelper.hesaplariGetir(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: ListView.builder(
                  shrinkWrap: true,
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
                                  snapshot.data[index].hesapAdi,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  snapshot.data[index].accountTypeID == 1
                                      ? 'Nakit Para'
                                      : (snapshot.data[index].accountTypeID == 2
                                          ? 'Banka Hesabı'
                                          : 'Kredi Kartı'),
                                ),
                                trailing: FutureBuilder<double>(
                                    future: _databaseHelper.getBalance(
                                        snapshot.data[index].hesapID),
                                    builder: (context, snapshot) {
                                      return Text(
                                          snapshot.data != null
                                              ? '${(snapshot.data.floor()).toString()} TL'
                                              : "0 TL",
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold));
                                    }),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 0.14,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                _databaseHelper
                                    .deleteAccount(snapshot.data[index].hesapID)
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
                  }),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
