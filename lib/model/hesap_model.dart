class HesapModel {
  int hesapID;
  String hesapAdi;

  HesapModel({this.hesapAdi});

  HesapModel.fromMap(Map<String, dynamic> map)
      : hesapID = map["hesapID"],
        hesapAdi = map["hesapAdi"];

  Map<String, dynamic> toMap() {
    return {
      "hesapID": hesapID,
      "hesapAdi": hesapAdi,
    };
  }
}
