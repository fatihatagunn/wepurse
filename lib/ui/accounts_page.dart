import 'package:flutter/material.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';
import 'package:wepurseapp/ui/appbar_widget.dart';

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
    return Material(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBarWidget.withTitle("Hesaplar"),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade700,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddAccountPage(),
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
            child: FutureBuilder<List<HesapModel>>(
              future: _databaseHelper.hesaplariGetir(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.grey.shade400,
                                  child: ListTile(
                                    title: Text(snapshot.data[index].hesapAdi),
                                    subtitle: Text(
                                      snapshot.data[index].accountTypeID == 1
                                          ? 'Nakit Para'
                                          : (snapshot.data[index]
                                                      .accountTypeID ==
                                                  2
                                              ? 'Banka Hesabı'
                                              : 'Kredi Kartı'),
                                    ),
                                    trailing: FutureBuilder<double>(
                                        future: _databaseHelper.getBalance(
                                            snapshot.data[index].hesapID),
                                        builder: (context, snapshot) {
                                          return Text(
                                              snapshot.data != null
                                                  ? '${snapshot.data.toString()} TL'
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
                                        .deleteAccount(
                                            snapshot.data[index].hesapID)
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
                      });
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
