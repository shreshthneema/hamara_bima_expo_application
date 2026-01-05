class StallVisitEntryResMainModel {
  StallVisitEntryResMainModel({
    List<StallVisitEntryResDataModel>? value,
  }) {
    _value = value;
  }

  StallVisitEntryResMainModel.fromJson(dynamic json) {
    if (json['value'] != null) {
      _value = [];
      json['value'].forEach((v) {
        _value?.add(StallVisitEntryResDataModel.fromJson(v));
      });
    }
  }
  List<StallVisitEntryResDataModel>? _value;

  List<StallVisitEntryResDataModel>? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_value != null) {
      map['value'] = _value?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class StallVisitEntryResDataModel {
  StallVisitEntryResDataModel.fromJson(dynamic json) {
    _id = json['Id'];
    _stallId = json['StallId'];
    _stallName = json['StallName'];
    _visitorRegNo = json['VisitorRegNo'];
    _visitorName = json['VisitorName'];
    _visitorOrganization = json['VisitorOrganization'];
    _registrationDate = json['RegistrationDate'];
    _visitorEmailId = json['VisitorEmailId'];

    _visitorDesignation = json['VisitorDesignation'];
    _visitorMobileNo = json['VisitorMobileNo'];
  }

  StallVisitEntryResDataModel({
    int? id,
    int? stallId,
    String? stallName,
    int? visitorRegNo,
    String? visitorName,
    String? visitorOrganization,
    String? registrationDate,
    String? visitorEmailId,
    String? visitorMobileNo,
    String? visitorAddress,
    String? visitorDesignation,
  }) {
    _id = id;
    _stallId = stallId;
    _stallName = stallName;
    _visitorRegNo = visitorRegNo;
    _visitorName = visitorName;
    _visitorOrganization = visitorOrganization;
    _registrationDate = registrationDate;
    _visitorEmailId = visitorEmailId;
    _visitorMobileNo = visitorMobileNo;
    _visitorAddress = visitorAddress;
    _visitorDesignation = visitorDesignation;
  }
  int? _id;
  int? _stallId;
  String? _stallName;
  int? _visitorRegNo;
  String? _visitorName;
  String? _visitorOrganization;
  String? _registrationDate;
  String? _visitorEmailId;
  String? _visitorMobileNo;
  String? _visitorAddress;
  String? _visitorDesignation;

  int? get id => _id;
  int? get stallId => _stallId;
  String? get stallName => _stallName;
  int? get visitorRegNo => _visitorRegNo;
  String? get visitorName => _visitorName;
  String? get visitorOrganization => _visitorOrganization;
  String? get registrationDate => _registrationDate;
  String? get visitorEmailId => _visitorEmailId;
  String? get visitorDesignation => _visitorDesignation;
  String? get visitorMobileNo => _visitorMobileNo;
  String? get visitorAddress => _visitorAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StallId'] = _stallId;
    map['StallName'] = _stallName;
    map['VisitorRegNo'] = _visitorRegNo;
    map['VisitorName'] = _visitorName;
    map['VisitorOrganization'] = _visitorOrganization;
    map['RegistrationDate'] = _registrationDate;
    map['VisitorEmailId'] = _visitorEmailId;
    map['VisitorDesignation'] = _visitorDesignation;
    map['VisitorMobileNo'] = _visitorMobileNo;

    return map;
  }
}
