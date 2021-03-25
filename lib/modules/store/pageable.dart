class Pageable {
  int _totalPages;
  int _totalElements;
  int _number;
  int _numberOfElements;
  bool _first;
  bool _last;
  bool _empty;

  Pageable(
      {int totalPages,
      int totalElements,
      int number,
      int numberOfElements,
      bool first,
      bool last,
      bool empty}) {
    this._totalPages = totalPages;
    this._totalElements = totalElements;
    this._number = number;
    this._numberOfElements = numberOfElements;
    this._first = first;
    this._last = last;
    this._empty = empty;
  }

  int get totalPages => _totalPages;
  set totalPages(int totalPages) => _totalPages = totalPages;
  int get totalElements => _totalElements;
  set totalElements(int totalElements) => _totalElements = totalElements;
  int get number => _number;
  set number(int number) => _number = number;
  int get numberOfElements => _numberOfElements;
  set numberOfElements(int numberOfElements) =>
      _numberOfElements = numberOfElements;
  bool get first => _first;
  set first(bool first) => _first = first;
  bool get last => _last;
  set last(bool last) => _last = last;
  bool get empty => _empty;
  set empty(bool empty) => _empty = empty;

  Pageable.fromJson(Map<String, dynamic> json) {
    _totalPages = json['totalPages'];
    _totalElements = json['totalElements'];
    _number = json['number'];
    _numberOfElements = json['numberOfElements'];
    _first = json['first'];
    _last = json['last'];
    _empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPages'] = this._totalPages;
    data['totalElements'] = this._totalElements;
    data['number'] = this._number;
    data['numberOfElements'] = this._numberOfElements;
    data['first'] = this._first;
    data['last'] = this._last;
    data['empty'] = this._empty;
    return data;
  }
}