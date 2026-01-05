class UserResMainModel {
  UserResMainModel({List<UserResDataModel>? value}) {
    _value = value;
  }

  UserResMainModel.fromJson(dynamic json) {
    if (json['value'] != null) {
      _value = [];
      json['value'].forEach((v) {
        _value?.add(UserResDataModel.fromJson(v));
      });
    }
  }
  List<UserResDataModel>? _value;

  List<UserResDataModel>? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_value != null) {
      map['value'] = _value?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class UserResDataModel {
  UserResDataModel({int? userId, String? username, String? passwordHash, String? userType, bool? isActive, String? createdAt, String? updatedAt}) {
    _userId = userId;
    _username = username;
    _passwordHash = passwordHash;
    _userType = userType;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  UserResDataModel.fromJson(dynamic json) {
    _userId = json['UserId'];
    _username = json['Username'];
    _passwordHash = json['PasswordHash'];
    _userType = json['UserType'];
    _isActive = json['IsActive'];
    _createdAt = json['CreatedAt'];
    _updatedAt = json['UpdatedAt'];
  }
  int? _userId;
  String? _username;
  String? _passwordHash;
  String? _userType;
  bool? _isActive;
  String? _createdAt;
  String? _updatedAt;

  int? get userId => _userId;
  String? get username => _username;
  String? get passwordHash => _passwordHash;
  String? get userType => _userType;
  bool? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserId'] = _userId;
    map['Username'] = _username;
    map['PasswordHash'] = _passwordHash;
    map['UserType'] = _userType;
    map['IsActive'] = _isActive;
    map['CreatedAt'] = _createdAt;
    map['UpdatedAt'] = _updatedAt;
    return map;
  }
}
