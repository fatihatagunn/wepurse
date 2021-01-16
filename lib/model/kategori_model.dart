class KategoriModel {
  int kategoriID;
  String kategoriAdi;
  String kategoriTipi;

  KategoriModel({this.kategoriAdi, this.kategoriTipi});

  KategoriModel.fromMap(Map<String, dynamic> map)
      : kategoriAdi = map["kategoriAdi"],
        kategoriTipi = map["kategoriTipi"],
        kategoriID = map["kategoriID"];

  Map<String, dynamic> toMap() {
    return {
      "kategoriAdi": kategoriAdi,
      "kategoriTipi": kategoriTipi,
      "kategoriID": kategoriID,
    };
  }
}
