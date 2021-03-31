class States {
  int? _id;
  int _codeUf = 0;
  String _name = "";
  String _uf = "";

  States({int? id, int codeUf = 0, String name = "", String uf = ""}) {
    this._id = id;
    this._codeUf = codeUf;
    this._name = name;
    this._uf = uf;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int get codeUf => _codeUf;
  set codeUf(int codeUf) => _codeUf = codeUf;
  String get name => _name;
  set name(String name) => _name = name;
  String get uf => _uf;
  set uf(String uf) => _uf = uf;

  States.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _codeUf = json['codeUf'];
    _name = json['name'];
    _uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['codeUf'] = this._codeUf;
    data['name'] = this._name;
    data['uf'] = this._uf;
    return data;
  }
}
