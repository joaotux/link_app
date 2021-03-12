class ProductStock {
  int _id;
  String _description;
  int _amount;
  int _max;
  int _min;

  ProductStock({int id, String description, int amount, int max, int min}) {
    this._id = id;
    this._description = description;
    this._amount = amount;
    this._max = max;
    this._min = min;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get description => _description;
  set description(String description) => _description = description;
  int get amount => _amount;
  set amount(int amount) => _amount = amount;
  int get max => _max;
  set max(int max) => _max = max;
  int get min => _min;
  set min(int min) => _min = min;

  ProductStock.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _description = json['description'];
    _amount = json['amount'];
    _max = json['max'];
    _min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['description'] = this._description;
    data['amount'] = this._amount;
    data['max'] = this._max;
    data['min'] = this._min;
    return data;
  }
}
