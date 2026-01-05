class GateEntryResMainModel {
  GateEntryResMainModel({List<GateEntryResDataModel>? value}) {
    _value = value;
  }

  GateEntryResMainModel.fromJson(dynamic json) {
    if (json['value'] != null) {
      _value = [];
      json['value'].forEach((v) {
        _value?.add(GateEntryResDataModel.fromJson(v));
      });
    }
  }
  List<GateEntryResDataModel>? _value;

  List<GateEntryResDataModel>? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_value != null) {
      map['value'] = _value?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class GateEntryResDataModel {
  GateEntryResDataModel({int? entryId, String? regNo, int? userId, String? isVerified, dynamic remarks, String? createdAt}) {
    _entryId = entryId;
    _regNo = regNo;
    _userId = userId;
    _isVerified = isVerified;
    _remarks = remarks;
    _createdAt = createdAt;
  }

  GateEntryResDataModel.fromJson(dynamic json) {
    _entryId = json['EntryId'];
    _regNo = json['RegNo'];
    _userId = json['UserId'];
    _isVerified = json['IsVerified'];
    _remarks = json['Remarks'];
    _createdAt = json['CreatedAt'];
  }
  int? _entryId;
  String? _regNo;
  int? _userId;
  String? _isVerified;
  dynamic _remarks;
  String? _createdAt;

  set regNo(String? value) {
    _regNo = value;
  }

  set remarks(dynamic value) {
    _remarks = value;
  }

  set isVerified(String? value) {
    _isVerified = value;
  }

  int? get entryId => _entryId;
  String? get regNo => _regNo;
  int? get userId => _userId;
  String? get isVerified => _isVerified;
  dynamic get remarks => _remarks;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // map['EntryId'] = _entryId;
    map['RegNo'] = _regNo;
    map['UserId'] = _userId;
    map['IsVerified'] = _isVerified;
    map['Remarks'] = _remarks;
    map['CreatedAt'] = _createdAt;
    return map;
  }
}
