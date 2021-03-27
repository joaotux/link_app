class ProductCategory {
  int? _id;
  String _description = "";

  ProductCategory({int? id, String description = ""}) {
    this._id = id;
    this._description = description;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String get description => _description;
  set description(String description) => _description = description;

  ProductCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['description'] = this._description;
    return data;
  }
}
