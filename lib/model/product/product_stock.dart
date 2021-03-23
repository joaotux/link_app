class ProductStock {
  int _id;
  String _description;
  double _amount;
  double _max;
  double _min;

  ProductStock(
      {int id, String description, double amount, double max, double min}) {
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
  double get amount => _amount;
  set amount(double amount) => _amount = amount;
  double get max => _max;
  set max(double max) => _max = max;
  double get min => _min;
  set min(double min) => _min = min;

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
