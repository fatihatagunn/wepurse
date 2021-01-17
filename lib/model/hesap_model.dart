class HesapModel {
  int hesapID;
  String hesapAdi;
  int accountTypeID;
  String cutOffDate;

  HesapModel({this.hesapAdi, this.accountTypeID, this.cutOffDate});

  HesapModel.fromMap(Map<String, dynamic> map)
      : hesapID = map["hesapID"],
        hesapAdi = map["hesapAdi"],
        accountTypeID = map['accountTypeID'],
        cutOffDate = map['cutOffDate'];

  Map<String, dynamic> toMap() {
    return {
      "hesapID": hesapID,
      "hesapAdi": hesapAdi,
      "accountTypeID": accountTypeID,
      "cutOffDate": cutOffDate,
    };
  }

  @override
  String toString() {
    return 'HesapModel{hesapID: $hesapID, hesapAdi: $hesapAdi, accountTypeID: $accountTypeID, cutOffDate: $cutOffDate}';
  }
}
