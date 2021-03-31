class Phone {
  int? _id;
  String _number = "";
  String _type = "";

  Phone({int? id, String number = "", String type = ""}) {
    this._id = id;
    this._number = number;
    this._type = type;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String get number => _number;
  set number(String number) => _number = number;
  String get type => _type;
  set type(String type) => _type = type;

  Phone.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _number = json['number'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['number'] = this._number;
    data['type'] = this._type;
    return data;
  }
}
