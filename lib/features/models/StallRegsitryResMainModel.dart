class StallRegsitryResMainModel {
  StallRegsitryResMainModel({
    List<StallRegsitryResDataModel>? value,
  }) {
    _value = value;
  }

  StallRegsitryResMainModel.fromJson(dynamic json) {
    if (json['value'] != null) {
      _value = [];
      json['value'].forEach((v) {
        _value?.add(StallRegsitryResDataModel.fromJson(v));
      });
    }
  }
  List<StallRegsitryResDataModel>? _value;

  List<StallRegsitryResDataModel>? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_value != null) {
      map['value'] = _value?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class StallRegsitryResDataModel {
  StallRegsitryResDataModel({
    int? autoNo,
    dynamic regNo,
    String? name,
    int? companyId,
    String? regDate,
    String? entryDate,
    EntryTime? entryTime,
    int? activeInd,
    int? cityCd,
    String? entryDateTime,
    String? vaccinatedYN,
  }) {
    _autoNo = autoNo;
    _regNo = regNo;
    _name = name;
    _companyId = companyId;
    _regDate = regDate;
    _entryDate = entryDate;
    _entryTime = entryTime;
    _activeInd = activeInd;
    _cityCd = cityCd;
    _entryDateTime = entryDateTime;
    _vaccinatedYN = vaccinatedYN;
  }

  StallRegsitryResDataModel.fromJson(dynamic json) {
    _autoNo = json['AutoNo'];
    _regNo = json['RegNo'];
    _name = json['Name'];
    _companyId = json['CompanyId'];
    _regDate = json['RegDate'];
    _entryDate = json['EntryDate'];
    _entryTime = json['EntryTime'] != null ? EntryTime.fromJson(json['EntryTime']) : null;
    _activeInd = json['ActiveInd'];
    _cityCd = json['CityCd'];
    _entryDateTime = json['EntryDateTime'];
    _vaccinatedYN = json['VaccinatedYN'];
  }
  int? _autoNo;
  dynamic _regNo;
  String? _name;
  int? _companyId;
  String? _regDate;
  String? _entryDate;
  EntryTime? _entryTime;
  int? _activeInd;
  int? _cityCd;
  String? _entryDateTime;
  String? _vaccinatedYN;

  int? get autoNo => _autoNo;
  dynamic get regNo => _regNo;
  String? get name => _name;
  int? get companyId => _companyId;
  String? get regDate => _regDate;
  String? get entryDate => _entryDate;
  EntryTime? get entryTime => _entryTime;
  int? get activeInd => _activeInd;
  int? get cityCd => _cityCd;
  String? get entryDateTime => _entryDateTime;
  String? get vaccinatedYN => _vaccinatedYN;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AutoNo'] = _autoNo;
    map['RegNo'] = _regNo;
    map['Name'] = _name;
    map['CompanyId'] = _companyId;
    map['RegDate'] = _regDate;
    map['EntryDate'] = _entryDate;
    if (_entryTime != null) {
      map['EntryTime'] = _entryTime?.toJson();
    }
    map['ActiveInd'] = _activeInd;
    map['CityCd'] = _cityCd;
    map['EntryDateTime'] = _entryDateTime;
    map['VaccinatedYN'] = _vaccinatedYN;
    return map;
  }
}

class EntryTime {
  EntryTime({
    int? hours,
    int? minutes,
    int? seconds,
    int? milliseconds,
    int? ticks,
    int? days,
    double? totalDays,
    double? totalHours,
    int? totalMilliseconds,
    int? totalMinutes,
    int? totalSeconds,
  }) {
    _hours = hours;
    _minutes = minutes;
    _seconds = seconds;
    _milliseconds = milliseconds;
    _ticks = ticks;
    _days = days;
    _totalDays = totalDays;
    _totalHours = totalHours;
    _totalMilliseconds = totalMilliseconds;
    _totalMinutes = totalMinutes;
    _totalSeconds = totalSeconds;
  }

  EntryTime.fromJson(dynamic json) {
    _hours = json['Hours'];
    _minutes = json['Minutes'];
    _seconds = json['Seconds'];
    _milliseconds = json['Milliseconds'];
    _ticks = json['Ticks'];
    _days = json['Days'];
    _totalDays = json['TotalDays'];
    _totalHours = json['TotalHours'];
    _totalMilliseconds = json['TotalMilliseconds'];
    _totalMinutes = json['TotalMinutes'];
    _totalSeconds = json['TotalSeconds'];
  }
  int? _hours;
  int? _minutes;
  int? _seconds;
  int? _milliseconds;
  int? _ticks;
  int? _days;
  double? _totalDays;
  double? _totalHours;
  int? _totalMilliseconds;
  int? _totalMinutes;
  int? _totalSeconds;

  int? get hours => _hours;
  int? get minutes => _minutes;
  int? get seconds => _seconds;
  int? get milliseconds => _milliseconds;
  int? get ticks => _ticks;
  int? get days => _days;
  double? get totalDays => _totalDays;
  double? get totalHours => _totalHours;
  int? get totalMilliseconds => _totalMilliseconds;
  int? get totalMinutes => _totalMinutes;
  int? get totalSeconds => _totalSeconds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Hours'] = _hours;
    map['Minutes'] = _minutes;
    map['Seconds'] = _seconds;
    map['Milliseconds'] = _milliseconds;
    map['Ticks'] = _ticks;
    map['Days'] = _days;
    map['TotalDays'] = _totalDays;
    map['TotalHours'] = _totalHours;
    map['TotalMilliseconds'] = _totalMilliseconds;
    map['TotalMinutes'] = _totalMinutes;
    map['TotalSeconds'] = _totalSeconds;
    return map;
  }
}
