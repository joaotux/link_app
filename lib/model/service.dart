import 'package:link_app/model/company.dart';

class Service {
  int? _id;
  String _description = "";
  String _code = "";
  double _priceSales = 0.0;
  double _priceCost = 0.0;
  bool _active = true;
  Company? _company;

  Service(
      {int? id,
      String description = "",
      String code = "",
      double priceSales = 0.0,
      double priceCost = 0.0,
      bool active = true,
      Company? company}) {
    this._id = id;
    this._description = description;
    this._code = code;
    this._priceSales = priceSales;
    this._priceCost = priceCost;
    this._active = active;
    this._company = company;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String get description => _description;
  set description(String description) => _description = description;
  String get code => _code;
  set code(String code) => _code = code;
  double get priceSales => _priceSales;
  set priceSales(double priceSales) => _priceSales = priceSales;
  double get priceCost => _priceCost;
  set priceCost(double priceCost) => _priceCost = priceCost;
  bool get active => _active;
  set active(bool active) => _active = active;
  Company? get company => _company;
  set company(Company? company) => _company = company;

  Service.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _description = json['description'];
    _code = json['code'];
    _priceSales = json['priceSales'];
    _priceCost = json['priceCost'];
    _active = json['active'];
    _company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['description'] = this._description;
    data['code'] = this._code;
    data['priceSales'] = this._priceSales;
    data['priceCost'] = this._priceCost;
    data['active'] = this._active;
    if (this._company != null) {
      data['company'] = this._company!.toJson();
    }
    return data;
  }
}
