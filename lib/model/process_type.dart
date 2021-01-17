class ProcessType {
  int _processTypeID;
  String _processTypeName;

  int get processTypeID => _processTypeID;

  set processTypeID(int value) {
    _processTypeID = value;
  }

  String get processTypeName => _processTypeName;

  set processTypeName(String value) {
    _processTypeName = value;
  }

  ProcessType(this._processTypeName);

  ProcessType.fromMap(Map<String, dynamic> map)
      : _processTypeID = map['processTypeID'],
        _processTypeName = map['processTypeName'];

  Map<String, dynamic> toMap() {
    return {
      "processTypeID": _processTypeID,
      "processTypeName": _processTypeName,
    };
  }

  @override
  String toString() {
    return 'ProcessType{_processTypeID: $_processTypeID, _processTypeName: $_processTypeName}';
  }
}