import 'package:flutter/material.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';
import 'package:wepurseapp/ui/add_category_page.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCategoryPage(),
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
              )),
        ],
        title: Text(
          "Kategoriler",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<KategoriModel>>(
        future: _databaseHelper.kategorileriGetir(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                                title: Text(snapshot.data[index].kategoriAdi),
                                subtitle: Text(
                                    snapshot.data[index].processTypeID == 1
                                        ? 'Gelir'
                                        : (snapshot.data[index].processTypeID ==
                                                2
                                            ? 'Gider'
                                            : 'Gider ve Gelir')),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _databaseHelper
                                  .deleteCategory(
                                      snapshot.data[index].kategoriID)
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              width: size.width * 0.14,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.grey.shade700,
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
