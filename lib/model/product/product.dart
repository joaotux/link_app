import 'package:link_app/model/product/product_stock.dart';

class Product {
  int _id;
  String _description;
  String _code;
  int _priceSales;
  double _priceCost;
  String _note;
  List<ProductStock> _stocks;

  Product(
      {int id,
      String description,
      String code,
      int priceSales,
      double priceCost,
      String note,
      List<ProductStock> stocks}) {
    this._id = id;
    this._description = description;
    this._code = code;
    this._priceSales = priceSales;
    this._priceCost = priceCost;
    this._note = note;
    this._stocks = stocks;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get description => _description;
  set description(String description) => _description = description;
  String get code => _code;
  set code(String code) => _code = code;
  int get priceSales => _priceSales;
  set priceSales(int priceSales) => _priceSales = priceSales;
  double get priceCost => _priceCost;
  set priceCost(double priceCost) => _priceCost = priceCost;
  String get note => _note;
  set note(String note) => _note = note;
  List<ProductStock> get stocks => _stocks;
  set stocks(List<ProductStock> stocks) => _stocks = stocks;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _description = json['description'];
    _code = json['code'];
    _priceSales = json['priceSales'];
    _priceCost = json['priceCost'];
    _note = json['note'];
    if (json['stocks'] != null) {
      _stocks = [];
      json['stocks'].forEach((v) {
        _stocks.add(ProductStock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['description'] = this._description;
    data['code'] = this._code;
    data['priceSales'] = this._priceSales;
    data['priceCost'] = this._priceCost;
    data['note'] = this._note;
    if (this._stocks != null) {
      data['stocks'] = this._stocks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
