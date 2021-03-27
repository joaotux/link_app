// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageable_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PageableController on _PageableControllerBase, Store {
  final _$_pageableAtom = Atom(name: '_PageableControllerBase._pageable');

  @override
  Pageable? get _pageable {
    _$_pageableAtom.reportRead();
    return super._pageable;
  }

  @override
  set _pageable(Pageable? value) {
    _$_pageableAtom.reportWrite(value, super._pageable, () {
      super._pageable = value;
    });
  }

  final _$_currentPageAtom = Atom(name: '_PageableControllerBase._currentPage');

  @override
  int get _currentPage {
    _$_currentPageAtom.reportRead();
    return super._currentPage;
  }

  @override
  set _currentPage(int value) {
    _$_currentPageAtom.reportWrite(value, super._currentPage, () {
      super._currentPage = value;
    });
  }

  final _$_PageableControllerBaseActionController =
      ActionController(name: '_PageableControllerBase');

  @override
  dynamic setPageable(Pageable value) {
    final _$actionInfo = _$_PageableControllerBaseActionController.startAction(
        name: '_PageableControllerBase.setPageable');
    try {
      return super.setPageable(value);
    } finally {
      _$_PageableControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic increment() {
    final _$actionInfo = _$_PageableControllerBaseActionController.startAction(
        name: '_PageableControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_PageableControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic decrement() {
    final _$actionInfo = _$_PageableControllerBaseActionController.startAction(
        name: '_PageableControllerBase.decrement');
    try {
      return super.decrement();
    } finally {
      _$_PageableControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentPage(int value) {
    final _$actionInfo = _$_PageableControllerBaseActionController.startAction(
        name: '_PageableControllerBase.setCurrentPage');
    try {
      return super.setCurrentPage(value);
    } finally {
      _$_PageableControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
