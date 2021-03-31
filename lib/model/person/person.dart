import 'package:link_app/model/person/address.dart';
import 'package:link_app/model/person/phone.dart';

class Person {
  int? _id;
  String _name = "";
  String _cpfcnpj = "";
  String _email = "";
  Address? _address;
  List<Phone>? _phone;

  Person(
      {int? id,
      String name = "",
      String cpfcnpj = "",
      String email = "",
      Address? address,
      List<Phone>? phone}) {
    this._id = id;
    this._name = name;
    this._cpfcnpj = cpfcnpj;
    this._email = email;
    this._address = address;
    this._phone = phone;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get cpfcnpj => _cpfcnpj;
  set cpfcnpj(String cpfcnpj) => _cpfcnpj = cpfcnpj;
  String get email => _email;
  set email(String email) => _email = email;
  Address? get address => _address;
  set address(Address? address) => _address = address;
  List<Phone>? get phone => _phone;
  set phone(List<Phone>? phone) => _phone = phone;

  Person.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _cpfcnpj = json['cpfcnpj'];
    _email = json['email'];
    _address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['phone'] != null) {
      _phone = [];
      json['phone'].forEach((v) {
        _phone!.add(new Phone.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['cpfcnpj'] = this._cpfcnpj;
    data['email'] = this._email;
    if (this._address != null) {
      data['address'] = this._address!.toJson();
    }
    if (this._phone != null) {
      data['phone'] = this._phone!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
