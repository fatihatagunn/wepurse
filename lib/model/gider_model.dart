class GiderModel {
  int gelirID;
  String gelirAciklamasi;
  int gelirTutari;
  String gelirTarihi;
  var kategoriTipi;
  var islemTipi;
  var hesapTipi;

  GiderModel(
      {this.gelirAciklamasi,
      this.kategoriTipi,
      this.gelirTarihi,
      this.gelirTutari,
      this.hesapTipi,
      this.islemTipi});

  GiderModel.fromMap(Map<String, dynamic> map)
      : gelirID = map["gelirID"],
        gelirAciklamasi = map["gelirAciklamasi"],
        kategoriTipi = map["kategoriTipi"],
        gelirTutari = map["gelirTutari"],
        gelirTarihi = map["gelirTarihi"],
        islemTipi = map["islemTipi"],
        hesapTipi = map["hesapTipi"];

  Map<String, dynamic> toMap() {
    return {
      "gelirID": gelirID,
      "kategoriTipi": kategoriTipi,
      "gelirTutari": gelirTutari,
      "gelirAciklamasi": gelirAciklamasi,
      "gelirTarihi": gelirTarihi,
      "hesapTipi": hesapTipi,
      "islemTipi": islemTipi,
    };
  }
}
