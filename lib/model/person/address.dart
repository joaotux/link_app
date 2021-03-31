import 'package:link_app/model/person/city.dart';
import 'package:link_app/model/person/states.dart';

class Address {
  int? _id;
  String? _street;
  String? _number;
  String? _zipCode;
  String? _info;
  String? _district;
  States? _state;
  City? _city;

  Address(
      {int? id,
      String? street,
      String? number,
      String? zipCode,
      String? info,
      String? district,
      States? state,
      City? city}) {
    this._id = id;
    this._street = street;
    this._number = number;
    this._zipCode = zipCode;
    this._info = info;
    this._district = district;
    this._state = state;
    this._city = city;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get street => _street;
  set street(String? street) => _street = street;
  String? get number => _number;
  set number(String? number) => _number = number;
  String? get zipCode => _zipCode;
  set zipCode(String? zipCode) => _zipCode = zipCode;
  String? get info => _info;
  set info(String? info) => _info = info;
  String? get district => _district;
  set district(String? district) => _district = district;
  States? get state => _state;
  set state(States? state) => _state = state;
  City? get city => _city;
  set city(City? city) => _city = city;

  Address.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _street = json['street'];
    _number = json['number'];
    _zipCode = json['zipCode'];
    _info = json['info'];
    _district = json['district'];
    _state = json['state'] != null ? new States.fromJson(json['state']) : null;
    _city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['street'] = this._street;
    data['number'] = this._number;
    data['zipCode'] = this._zipCode;
    data['info'] = this._info;
    data['district'] = this._district;
    if (this._state != null) {
      data['state'] = this._state!.toJson();
    }
    if (this._city != null) {
      data['city'] = this._city!.toJson();
    }
    return data;
  }
}
