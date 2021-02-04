class GelirModel {
  int gelirID;
  int processTypeID;
  String gelirAciklamasi;
  int accountID;
  double gelirTutari;
  String gelirTarihi;
  int categoryID;

  GelirModel(
      {this.gelirAciklamasi,
      this.categoryID,
      this.gelirTarihi,
      this.gelirTutari,
      this.accountID,
      this.processTypeID});

  GelirModel.fromMap(Map<String, dynamic> map)
      : gelirID = map["gelirID"],
        gelirAciklamasi = map["gelirAciklamasi"],
        categoryID = map["categoryID"],
        gelirTutari = map["gelirTutari"],
        gelirTarihi = map["gelirTarihi"],
        processTypeID = map["processTypeID"],
        accountID = map["accountID"];

  Map<String, dynamic> toMap() {
    return {
      "gelirID": gelirID,
      "categoryID": categoryID,
      "gelirTutari": gelirTutari,
      "gelirAciklamasi": gelirAciklamasi,
      "gelirTarihi": gelirTarihi,
      "accountID": accountID,
      "processTypeID": processTypeID,
    };
  }

  @override
  String toString() {
    return 'GelirModel{gelirID: $gelirID, processTypeID: $processTypeID, gelirAciklamasi: $gelirAciklamasi, accountID: $accountID, gelirTutari: $gelirTutari, gelirTarihi: $gelirTarihi, categoryID: $categoryID}';
  }
}
