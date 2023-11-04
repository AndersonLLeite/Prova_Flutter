// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infostore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InfoStore on _InfoStore, Store {
  late final _$_infoListAtom =
      Atom(name: '_InfoStore._infoList', context: context);

  @override
  ObservableList<String> get _infoList {
    _$_infoListAtom.reportRead();
    return super._infoList;
  }

  @override
  set _infoList(ObservableList<String> value) {
    _$_infoListAtom.reportWrite(value, super._infoList, () {
      super._infoList = value;
    });
  }

  late final _$_InfoStoreActionController =
      ActionController(name: '_InfoStore', context: context);

  @override
  dynamic addInfo(String info) {
    final _$actionInfo =
        _$_InfoStoreActionController.startAction(name: '_InfoStore.addInfo');
    try {
      return super.addInfo(info);
    } finally {
      _$_InfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeInfo(String info) {
    final _$actionInfo =
        _$_InfoStoreActionController.startAction(name: '_InfoStore.removeInfo');
    try {
      return super.removeInfo(info);
    } finally {
      _$_InfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateInfo(int index, String newInfo) {
    final _$actionInfo =
        _$_InfoStoreActionController.startAction(name: '_InfoStore.updateInfo');
    try {
      return super.updateInfo(index, newInfo);
    } finally {
      _$_InfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
