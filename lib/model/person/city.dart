class City {
  int? _id;
  int _code = 0;
  String _name = "";
  String _uf = "";

  City({int? id, int code = 0, String name = "", String uf = ""}) {
    this._id = id;
    this._code = code;
    this._name = name;
    this._uf = uf;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int get code => _code;
  set code(int code) => _code = code;
  String get name => _name;
  set name(String name) => _name = name;
  String get uf => _uf;
  set uf(String uf) => _uf = uf;

  City.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _code = json['code'];
    _name = json['name'];
    _uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['code'] = this._code;
    data['name'] = this._name;
    data['uf'] = this._uf;
    return data;
  }
}
