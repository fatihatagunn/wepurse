class GiderModel {
  int giderID;
  int processTypeID;
  String giderAciklamasi;
  int accountID;
  double giderTutari;
  String giderTarihi;
  int categoryID;

  GiderModel(
      {this.giderAciklamasi,
      this.categoryID,
      this.giderTarihi,
      this.giderTutari,
      this.accountID,
      this.processTypeID});

  GiderModel.fromMap(Map<String, dynamic> map)
      : giderID = map["giderID"],
        giderAciklamasi = map["giderAciklamasi"],
        categoryID = map["categoryID"],
        giderTutari = map["giderTutari"],
        giderTarihi = map["giderTarihi"],
        processTypeID = map["processTypeID"],
        accountID = map["accountID"];

  Map<String, dynamic> toMap() {
    return {
      "giderID": giderID,
      "categoryID": categoryID,
      "giderTutari": giderTutari,
      "giderAciklamasi": giderAciklamasi,
      "giderTarihi": giderTarihi,
      "accountID": accountID,
      "processTypeID": processTypeID,
    };
  }

  @override
  String toString() {
    return 'GiderModel{giderID: $giderID, processTypeID: $processTypeID, giderAciklamasi: $giderAciklamasi, accountID: $accountID, giderTutari: $giderTutari, giderTarihi: $giderTarihi, categoryID: $categoryID}';
  }
}
