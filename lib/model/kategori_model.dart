class KategoriModel {
  int kategoriID;
  String kategoriAdi;
  int processTypeID;

  KategoriModel({this.kategoriAdi, this.processTypeID});

  KategoriModel.fromMap(Map<String, dynamic> map)
      : kategoriAdi = map["kategoriAdi"],
        processTypeID = map["processTypeID"],
        kategoriID = map["kategoriID"];

  Map<String, dynamic> toMap() {
    return {
      "kategoriAdi": kategoriAdi,
      "processTypeID": processTypeID,
      "kategoriID": kategoriID,
    };
  }

  @override
  String toString() {
    return 'KategoriModel{kategoriID: $kategoriID, kategoriAdi: $kategoriAdi, processTypeID: $processTypeID}';
  }
}
