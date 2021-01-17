import 'package:flutter/material.dart';
import 'package:wepurseapp/model/user_model.dart';
import 'package:wepurseapp/services/database_helper_service.dart';
import 'package:wepurseapp/ui/edit_profile.dart';

import 'accounts_page.dart';
import 'add_account_page.dart';
import 'add_category_page.dart';
import 'all_expenses_page.dart';
import 'all_incomes_page.dart';
import 'categories_page.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerPageState();
  }
}

class DrawerPageState extends State<DrawerPage> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  Future kullaniciyiGetir;

  @override
  void initState() {
    super.initState();
    kullaniciyiGetir = _databaseHelper.kullaniciyiGetir();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: <Widget>[
          FutureBuilder<List<UserModel>>(
            future: kullaniciyiGetir,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return UserAccountsDrawerHeader(
                  accountName: Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(snapshot.data[0].userName),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditProfile()));
                          },
                          child: Container(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(right: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //KULLANICI GİRİŞİNDEN ALINAN _userName VERİSİ
                  accountEmail: Text(snapshot.data[0].userEmail),
                  //KULLANICI GİRİŞİNDEN ALINAN _userMail VERİSİ
                  currentAccountPicture:
                      Image.asset("assets/images/wallet_tecno.png"),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                  ),
                );
              } else
                return CircularProgressIndicator();
            },
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.category_outlined,
                      color: Colors.indigo,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Kategoriler "),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.indigo,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoriesPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.category_outlined,
                      color: Colors.indigo,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Kategori Ekle "),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.indigo,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCategoryPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.indigo,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Hesaplar"),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.indigo,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountsPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.indigo,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Hesap Ekle "),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.indigo,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAccountPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.indigo,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Tüm Gelirler "),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.indigo,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllIncomesPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.money_off_outlined,
                      color: Colors.indigo,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Tüm Giderler "),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.indigo,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllExpensesPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
