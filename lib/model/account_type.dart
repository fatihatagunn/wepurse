class AccountType {
  int _accountTypeID;
  String _accountTypeName;

  int get accountTypeID => _accountTypeID;

  set accountTypeID(int value) {
    _accountTypeID = value;
  }

  String get accountTypeName => _accountTypeName;

  set accountTypeName(String value) {
    _accountTypeName = value;
  }

  AccountType(this._accountTypeName);

  AccountType.fromMap(Map<String, dynamic> map)
      : _accountTypeID = map['accountTypeID'],
        _accountTypeName = map['accountTypeName'];

  Map<String, dynamic> toMap() {
    return {
      "accountTypeID": _accountTypeID,
      "accountTypeName": _accountTypeName,
    };
  }

  @override
  String toString() {
    return 'AccountType{_accountTypeID: $_accountTypeID, _accountTypeName: $_accountTypeName}';
  }
}