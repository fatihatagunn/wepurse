import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerPageState();
  }
}

class DrawerPageState extends State<DrawerPage> {
  String _userName = "wepurse app";
  String _userMail = "wepurse@app.fl";

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(_userName),
            //KULLANICI GİRİŞİNDEN ALINAN _userName VERİSİ
            accountEmail: Text(_userMail),
            //KULLANICI GİRİŞİNDEN ALINAN _userMail VERİSİ
            currentAccountPicture:
                Image.asset("assets/images/wallet_tecno.png"),

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
                  onTap: () {},
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
                  onTap: () {},
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
                  onTap: () {},
                ),
                Divider(
                  color: Colors.indigo,
                  indent: 20,
                  endIndent: 20,
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.settings_applications_outlined,
                      color: Colors.indigo,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Ayarlar"),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.indigo,
                  ),
                  onTap: () {},
                ),


              ],
            ),
          ),

        ],
      ),
    );
  }
}

