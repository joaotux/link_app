import 'package:link_app/model/product/product_category.dart';
import 'package:link_app/model/product/product_stock.dart';
import 'package:link_app/model/provider.dart';

class Product {
  int? _id;
  late String _description;
  late String _code;
  late String _barCode;
  late double _priceSales;
  late double _priceCost;
  late String _note;
  ProductCategory? _category;
  Provider? _provider;
  List<ProductStock>? _stocks;

  Product(
      {int? id,
      String description = "",
      String code = "",
      String barCode = "",
      double priceSales = 0.0,
      double priceCost = 0.0,
      String note = "",
      ProductCategory? category,
      Provider? provider,
      List<ProductStock>? stocks}) {
    this._id = id;
    this._description = description;
    this._code = code;
    this._barCode = barCode;
    this._priceSales = priceSales;
    this._priceCost = priceCost;
    this._note = note;
    this._category = category;
    this._provider = provider;
    this._stocks = stocks;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String get description => _description;
  set description(String description) => _description = description;
  String get code => _code;
  set code(String code) => _code = code;
  String get barCode => _barCode;
  set barCode(String barCod) => _barCode = barCode;
  double get priceSales => _priceSales;
  set priceSales(double priceSales) => _priceSales = priceSales;
  double get priceCost => _priceCost;
  set priceCost(double priceCost) => _priceCost = priceCost;
  String get note => _note;
  set note(String note) => _note = note;
  ProductCategory? get category => _category;
  set category(ProductCategory? category) => _category = category;
  Provider? get provider => _provider;
  set provider(Provider? provider) => _provider = provider;
  List<ProductStock>? get stocks => _stocks;
  set stocks(List<ProductStock>? stocks) => _stocks = stocks;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _description = json['description'];
    _code = json['code'];
    _barCode = json['barCode'];
    _priceSales = json['priceSales'];
    _priceCost = json['priceCost'];
    _note = json['note'];
    _category = json['category'] != null
        ? new ProductCategory.fromJson(json['category'])
        : null;
    _provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    if (json['stocks'] != null) {
      _stocks = [];
      json['stocks'].forEach((v) {
        _stocks!.add(ProductStock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['description'] = this._description;
    data['code'] = this._code;
    data['barCode'] = this._barCode;
    data['priceSales'] = this._priceSales;
    data['priceCost'] = this._priceCost;
    data['note'] = this._note;
    if (this._category != null) {
      data['category'] = this._category!.toJson();
    }
    if (this._provider != null) {
      data['provider'] = this._provider!.toJson();
    }
    if (this._stocks != null) {
      data['stocks'] = this._stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
