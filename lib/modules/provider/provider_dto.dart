class ProviderDTO {
  int? _id;
  String _name = "";
  bool _active = false;

  ProviderDTO({int? id, String name = "", bool active = false}) {
    this._id = id;
    this._name = name;
    this._active = active;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  bool get active => _active;
  set active(bool active) => _active = active;

  ProviderDTO.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['active'] = this._active;
    return data;
  }
}
