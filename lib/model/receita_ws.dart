class ReceitaWs {
  String _nome = "";
  String _fantasia = "";
  String _complemento = "";
  String _telefone = "";
  String _email = "";
  String _logradouro = "";
  String _numero = "";
  String _bairro = "";
  String _cep = "";
  String _municipio = "";
  String _uf = "";
  String _status = "";
  String _message = "";

  ReceitaWs(
      {String nome = "",
      String fantasia = "",
      String complemento = "",
      String telefone = "",
      String email = "",
      String logradouro = "",
      String numero = "",
      String bairro = "",
      String cep = "",
      String municipio = "",
      String uf = "",
      String status = "",
      String message = ""}) {
    this._nome = nome;
    this._fantasia = fantasia;
    this._complemento = complemento;
    this._telefone = telefone;
    this._email = email;
    this._logradouro = logradouro;
    this._numero = numero;
    this._bairro = bairro;
    this._cep = cep;
    this._municipio = municipio;
    this._uf = uf;
    this._status = status;
    this._message = message;
  }

  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get fantasia => _fantasia;
  set fantasia(String fantasia) => _fantasia = fantasia;
  String get complemento => _complemento;
  set complemento(String complemento) => _complemento = complemento;
  String get telefone => _telefone;
  set telefone(String telefone) => _telefone = telefone;
  String get email => _email;
  set email(String email) => _email = email;
  String get logradouro => _logradouro;
  set logradouro(String logradouro) => _logradouro = logradouro;
  String get numero => _numero;
  set numero(String numero) => _numero = numero;
  String get bairro => _bairro;
  set bairro(String bairro) => _bairro = bairro;
  String get cep => _cep;
  set cep(String cep) => _cep = cep;
  String get municipio => _municipio;
  set municipio(String municipio) => _municipio = municipio;
  String get uf => _uf;
  set uf(String uf) => _uf = uf;
  String get status => _status;
  set status(String status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;

  ReceitaWs.fromJson(Map<String, dynamic> json) {
    _nome = json['nome'];
    _fantasia = json['fantasia'];
    _complemento = json['complemento'];
    _telefone = json['telefone'];
    _email = json['email'];
    _logradouro = json['logradouro'];
    _numero = json['numero'];
    _bairro = json['bairro'];
    _cep = json['cep'];
    _municipio = json['municipio'];
    _uf = json['uf'];
    _status = json['status'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this._nome;
    data['fantasia'] = this._fantasia;
    data['complemento'] = this._complemento;
    data['telefone'] = this._telefone;
    data['email'] = this._email;
    data['logradouro'] = this._logradouro;
    data['numero'] = this._numero;
    data['bairro'] = this._bairro;
    data['cep'] = this._cep;
    data['municipio'] = this._municipio;
    data['uf'] = this._uf;
    data['status'] = this._status;
    data['message'] = this._message;
    return data;
  }
}
