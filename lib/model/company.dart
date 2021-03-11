import 'package:link_app/model/user.dart';

class Company {
  String _id;
  String _name;
  String _identificationNumber;
  String _identificationType;
  String _phone;
  String _info1;
  String _info2;
  List<User> _users;

  Company(
      {String id,
      String name,
      String identificationNumber,
      String identificationType,
      String phone,
      String info1,
      String info2,
      List<User> users}) {
    this._id = id;
    this._name = name;
    this._identificationNumber = identificationNumber;
    this._identificationType = identificationType;
    this._phone = phone;
    this._info1 = info1;
    this._info2 = info2;
    this._users = users;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get identificationNumber => _identificationNumber;
  set identificationNumber(String identificationNumber) =>
      _identificationNumber = identificationNumber;
  String get identificationType => _identificationType;
  set identificationType(String identificationType) =>
      _identificationType = identificationType;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;
  String get info1 => _info1;
  set info1(String info1) => _info1 = info1;
  String get info2 => _info2;
  set info2(String info2) => _info2 = info2;
  List<User> get users => _users;
  set users(List<User> users) => _users = users;

  Company.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _identificationNumber = json['identification_number'];
    _identificationType = json['identification_type'];
    _phone = json['phone'];
    _info1 = json['info1'];
    _info2 = json['info2'];
    if (json['users'] != null) {
      _users = <User>[];
      json['users'].forEach((v) {
        _users.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['identification_number'] = this._identificationNumber;
    data['identification_type'] = this._identificationType;
    data['phone'] = this._phone;
    data['info1'] = this._info1;
    data['info2'] = this._info2;
    if (this._users != null) {
      data['users'] = this._users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
