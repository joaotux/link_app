import 'package:link_app/model/person/person.dart';

class Provider {
  int? _id;
  String _fantasyName = "";
  bool _active = true;
  Person? _person;

  Provider(
      {int? id, bool active = true, String fantasyName = "", Person? person}) {
    this._fantasyName = fantasyName;
    this._active = active;
    this._person = person;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String get fantasyName => _fantasyName;
  set fantasyName(String fantasyName) => _fantasyName = fantasyName;
  bool get active => _active;
  set active(bool active) => _active = active;
  Person? get person => _person;
  set person(Person? person) => _person = person;

  Provider.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fantasyName = json['fantasyName'];
    _active = json['active'];
    _person =
        json['person'] != null ? new Person.fromJson(json['person']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fantasyName'] = this._fantasyName;
    data['active'] = this._active;
    if (this._person != null) {
      data['person'] = this._person!.toJson();
    }
    return data;
  }
}
