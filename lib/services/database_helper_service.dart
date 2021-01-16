import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wepurseapp/model/gelir_model.dart';
import 'package:wepurseapp/model/gider_model.dart';
import 'package:wepurseapp/model/hesap_model.dart';
import 'package:wepurseapp/model/kategori_model.dart';
import 'package:wepurseapp/model/user_model.dart';

class DatabaseHelper {
  static DatabaseHelper _databasehelper;
  static Database _database;

  factory DatabaseHelper() {
    if (_databasehelper == null) {
      _databasehelper = DatabaseHelper._internal();
      return _databasehelper;
    } else {
      return _databasehelper;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> _initializeDatabase() async {
    print("1");
    String databasesPath = await getDatabasesPath();
    String path = join(
        databasesPath, "wepurse.db"); // dosyanın yolunu ve adını sorguluyor

// Check if the database exists
    bool exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      //eğer böyle bir veri tabanı yoksa oluşturuluyor

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "wepurse.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      print("data bu $data");
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      //böyle bir veri tabanı varsa da açılıyor
    }

    return await openDatabase(path, readOnly: false);
    //veri tabanı açıldı ve hem yazma hem de okuma işlemleri yapılabiliyor
  }

  Future kullaniciEkle(UserModel userModel) async {
    Database db = await _getDatabase();
    int sonuc = await db.insert(
        "user",
        userModel
            .toMap()); // veri tabanına veri eklerken mape çevirmemiz gerekir
    return sonuc;
  }

  Future hesapEkle(HesapModel hesapModel) async {
    Database db = await _getDatabase();
    int sonuc = await db.insert(
        "hesaplar",
        hesapModel
            .toMap()); // veri tabanına veri eklerken mape çevirmemiz gerekir
    return sonuc;
  }

  Future gelirEkle(GelirModel gelirModel) async {
    Database db = await _getDatabase();
    int sonuc = await db.insert(
        "gelir",
        gelirModel
            .toMap()); // veri tabanına veri eklerken mape çevirmemiz gerekir
    return sonuc;
  }

  Future giderEkle(GiderModel giderModel) async {
    Database db = await _getDatabase();
    int sonuc = await db.insert(
        "gider",
        giderModel
            .toMap()); // veri tabanına veri eklerken mape çevirmemiz gerekir
    return sonuc;
  }

  Future kategoriEkle(KategoriModel kategoriModel) async {
    Database db = await _getDatabase();
    int sonuc = await db.insert(
        "kategoriler",
        kategoriModel
            .toMap()); // veri tabanına veri eklerken mape çevirmemiz gerekir
    return sonuc;
  }

  Future<List<UserModel>> kullaniciyiGetir() async {
    Database db = await _getDatabase();
    List<UserModel> kullanici = [];
    List<Map<String, dynamic>> sonuc =
        await db.rawQuery('select user.userName, user.userEmail from user');
    for (Map map in sonuc) {
      // verileri getirmek için mapden çeviriyoruz
      kullanici.add(UserModel.fromMap(map));
    }
    return kullanici;
  }

  Future<List<KategoriModel>> kategorileriGetir() async {
    Database db = await _getDatabase();
    List<KategoriModel> kategoriler = [];
    List<Map<String, dynamic>> sonuc = await db.rawQuery(
        'select kategoriler.kategoriAdi, kategoriler.kategoriID, kategoriler.kategoriTipi from kategoriler');
    for (Map map in sonuc) {
      // verileri getirmek için mapden çeviriyoruz
      kategoriler.add(KategoriModel.fromMap(map));
    }
    return kategoriler;
  }

  Future<List<GelirModel>> gelirleriGetir() async {
    Database db = await _getDatabase();
    List<GelirModel> gelirler = [];
    List<Map<String, dynamic>> sonuc = await db.rawQuery(
        'select gelir.gelirID, gelir.gelirAciklamasi, gelir.gelirTutari, gelir.gelirTarihi, gelir.islemTipi, gelir.kategoriTipi, gelir.hesapTipi from gelir');
    for (Map map in sonuc) {
      // verileri getirmek için mapden çeviriyoruz
      gelirler.add(GelirModel.fromMap(map));
    }
    return gelirler;
  }

  Future<List<GiderModel>> giderleriGetir() async {
    Database db = await _getDatabase();
    List<GiderModel> giderler = [];
    List<Map<String, dynamic>> sonuc = await db.rawQuery(
        'select gider.gelirID, gider.gelirAciklamasi, gider.gelirTutari, gider.gelirTarihi, gider.islemTipi, gider.kategoriTipi, gider.hesapTipi from gider');
    for (Map map in sonuc) {
      // verileri getirmek için mapden çeviriyoruz
      giderler.add(GiderModel.fromMap(map));
    }
    return giderler;
  }

  Future<List<HesapModel>> hesaplariGetir() async {
    Database db = await _getDatabase();
    List<HesapModel> hesaplar = [];
    List<Map<String, dynamic>> sonuc = await db
        .rawQuery('select hesaplar.hesapAdi, hesaplar.hesapID from hesaplar');
    for (Map map in sonuc) {
      // verileri getirmek için mapden çeviriyoruz
      hesaplar.add(HesapModel.fromMap(map));
    }
    return hesaplar;
  }
}
