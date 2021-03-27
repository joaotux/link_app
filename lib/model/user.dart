class User {
  String? _id;
  late String _email;
  late String _password;
  late int _number;

  User({String? id, String email = "", String password = "", int number = 0}) {
    this._id = id;
    this._email = email;
    this._password = password;
    this._number = number;
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String get email => _email;
  set email(String email) => _email = email;
  String get password => _password;
  set password(String password) => _password = password;
  int get number => _number;
  set number(int number) => _number = number;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _email = json['email'];
    _password = json['password'];
    _number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['email'] = this._email;
    data['password'] = this._password;
    data['number'] = this._number;
    return data;
  }

  Map<String, dynamic> toJsonLogin() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this._email;
    data['password'] = this._password;
    return data;
  }
}
