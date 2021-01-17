import 'package:flutter/material.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';
import 'package:wepurseapp/ui/add_category_page.dart';

import 'appbar_widget.dart';

class CategoriesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoriesPageState();
  }
}

class CategoriesPageState extends State<CategoriesPage> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBarWidget.withTitle("Kategoriler "),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCategoryPage(),
              ),
            );
          },
          backgroundColor: Colors.indigo,
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
            child: FutureBuilder<List<KategoriModel>>(
              future: _databaseHelper.kategorileriGetir(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: snapshot.data[index].processTypeID == 1 ? Colors.green : (snapshot.data[index].processTypeID == 2 ? Colors.red : Colors.amber),
                          child: ListTile(
                            title: Text(snapshot.data[index].kategoriAdi),
                            subtitle: Text(snapshot.data[index].processTypeID == 1 ? 'Gelir' : (snapshot.data[index].processTypeID == 2 ? 'Gider' : 'Gider ve Gelir')),
                          ),
                        );
                      }
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
